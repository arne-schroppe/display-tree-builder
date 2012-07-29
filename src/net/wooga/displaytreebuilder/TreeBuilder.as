package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import net.wooga.displaytreebuilder.grammar.BlockContent;
	import net.wooga.displaytreebuilder.grammar.BlockContent$CollectionProperty$BlockStart;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Finish;
	import net.wooga.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Property;
	import net.wooga.displaytreebuilder.grammar.BlockStart;
	import net.wooga.displaytreebuilder.grammar.DataDefinition;
	import net.wooga.displaytreebuilder.grammar.InstanceModification;
	import net.wooga.displaytreebuilder.grammar.Instantiation;
	import net.wooga.displaytreebuilder.grammar.ItemToUse;
	import net.wooga.displaytreebuilder.grammar.NameProperty;
	import net.wooga.displaytreebuilder.grammar.Storage;
	import net.wooga.displaytreebuilder.grammar.TreeStart;
	import net.wooga.displaytreebuilder.grammar._finish;
	import net.wooga.displaytreebuilder.grammar._setToThe;
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;
	import net.wooga.displaytreebuilder.tools.InstantiationTool;

	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;


	//TODO (arneschroppe 29/07/2012) instead of creating all elements on the fly, create a data structure internally and build tree on finish
	internal class TreeBuilder implements BlockContent$Property, _finish, ItemToUse, _setToThe, BlockContent$CollectionProperty$BlockStart, BlockContent$Finish, BlockContent$InstanceModification, BlockStart, DataDefinition, TreeStart, Instantiation, NameProperty, Storage {

		private var _currentContainersStack:Array = [
			[]
		];
		private var _currentObjectsStack:Array = [];

		private var _count:int;
		private var _collectionLength:int;

		private var _collection:*;
		private var _currentDataType:Class;

		private var _instancePropertyName:String;

		private var _isUnfinished:Boolean = false;

		private var _openSubTrees:int;

		private var _isCheckingUnfinishedStatements:Boolean = true;

		private var _delayedInstanceCreation:Boolean;
		private var _constructorArgs:Array;

		private var _initFunction:Function;


		public function set isCheckingUnfinishedStatements(value:Boolean):void {
			_isCheckingUnfinishedStatements = value;
		}

		public function get isCheckingUnfinishedStatements():Boolean {
			return _isCheckingUnfinishedStatements;
		}

		public function uses(object:DisplayObject):BlockStart {
			if(_isCheckingUnfinishedStatements && _isUnfinished) {
				throw new Error("Previous expression was unfinished. Add the 'finish()' keyword")
			}
			_openSubTrees = 0;
			_isUnfinished = true;

			_currentObjectsStack = [
				[object]
			];
			_count = 1;
			return this;
		}


		private function get currentContainers():Array {
			return _currentContainersStack[_currentContainersStack.length - 1];
		}


		private function get currentObjects():Array {
			return _currentObjectsStack[_currentObjectsStack.length - 1];
		}


		public function a(Type:Class):InstanceModification {
			createDelayedInstanceIfNeeded();
			initializePreviousElement();

			clearCurrentObjects();
			_currentDataType = Type;
			_delayedInstanceCreation = true;
			return this;
		}


		public function an(Type:Class):InstanceModification {
			return a(Type);
		}

		private function clearCurrentObjects():void {
			_currentObjectsStack.pop();
			_currentObjectsStack.push([]);
		}


		private function addClassInternal(container:DisplayObjectContainer, index:int, Type:Class):void {
			var instance:DisplayObject = DisplayObject(InstantiationTool.instantiate(Type, _constructorArgs));
			addInstanceInternal(container, index, instance);
		}


		private function addInstanceInternal(container:DisplayObjectContainer, index:int, instance:DisplayObject):void {
			container.addChild(instance);
			currentObjects.push(instance);
		}


		public function get containing():BlockContent {
			createDelayedInstanceIfNeeded();
			initializePreviousElement();

			_openSubTrees++;
			_currentContainersStack.push(currentObjects.concat());
			_currentObjectsStack.push([]);
			return this;
		}

		internal function createDelayedInstanceIfNeeded():void {
			if(!_delayedInstanceCreation) {
				return;
			}
			_delayedInstanceCreation = false;
			loopOnContainers(addClassInternal, [_currentDataType]);
			_constructorArgs = null;
		}


		public function times(count:int):Instantiation {

			createDelayedInstanceIfNeeded();
			initializePreviousElement();
			_count = count;
			return this;
		}


		public function get end():BlockContent$Finish {

			createDelayedInstanceIfNeeded();
			initializePreviousElement();

			_openSubTrees--;
			_currentContainersStack.pop();
			_currentObjectsStack.pop();

			return this;
		}

		public function withTheConstructorArguments(...args):BlockContent$InstanceModification {
			_constructorArgs = args;
			return this;
		}

		public function theInstance(object:DisplayObject):BlockContent$Property {

			createDelayedInstanceIfNeeded();
			initializePreviousElement();

			clearCurrentObjects();
			if(currentContainers.length > 1) {
				throw new Error("Cannot add an instance to several containers");
			}
			loopOnContainers(addInstanceInternal, [object]);
			return this;
		}


		private function loopOnContainers(method:Function, arguments:Array):void {

			var args:Array = arguments.concat();
			args.unshift(method);
			for(var i:int = 0; i < _count; ++i) {
				applyToAllContainers.apply(this, args);
			}

			_count = 1;
		}


		private function applyToAllObjects(method:Function, ...rest):void {
			var counter:int = 0;
			for each (var object:DisplayObject in currentObjects) {
				var actualArguments:Array = rest.concat();
				actualArguments.unshift(counter);
				actualArguments.unshift(object);
				method.apply(this, actualArguments);

				++counter;
			}
		}


		private function applyToAllContainers(method:Function, ...rest):void {
			var counter:int = 0;
			for each (var container:DisplayObjectContainer in currentContainers) {
				var actualArguments:Array = rest.concat();
				actualArguments.unshift(counter);
				actualArguments.unshift(container);
				method.apply(this, actualArguments);

				++counter;
			}
		}


		public function forEveryItemIn(collection:*):BlockContent$CollectionProperty__DataDef$BlockStart {
			_delayedInstanceCreation = false;

			if(collection is IIterable) {
				storeCollectionInArray(collection);
			}
			else if(collection is IIterator) {
				storeIteratorInArray(collection);
			}
			else {
				storeCollection(collection);
			}


			loopOnContainers(loopOnCollection, [_currentDataType]);

			return new DataDefinitionBranch(this);
		}


		private function loopOnCollection(container:DisplayObjectContainer, index:int, type:Class):void {
			for(var i:int = 0; i < _collectionLength; ++i) {
				addClassInternal(container, index, type)
			}

		}


		private function storeCollection(collection:*):void {
			_collection = collection;
			_collectionLength = collection.length;
		}

		private function storeCollectionInArray(collection:IIterable):void {
			var iterator:IIterator = collection.iterator();
			storeIteratorInArray(iterator);
		}

		private function storeIteratorInArray(iterator:IIterator):void {
			var storage:Array = [];
			while(iterator.hasNext()) {
				storage.push(iterator.next());
			}
			_collection = storage;
			_collectionLength = storage.length;
		}



		public function withTheProperty(instancePropertyName:String):_setToThe {
			createDelayedInstanceIfNeeded();
			_instancePropertyName = instancePropertyName;
			return this;
		}




		public function whichWillBeStoredIn(instances:Array):BlockContent$InstanceModification {
			createDelayedInstanceIfNeeded();
			for each(var instance:* in currentObjects) {
				instances.push(instance);
			}

			return this;
		}

		private function setPropertyOnObject(object:Object, index:int, propertyName:String, dataFieldName:String):void {
			var data:Object = _collection[index % _collectionLength];
			object[propertyName] = data[dataFieldName];
		}

		private function setPropertyOnObjectToInstance(object:Object, index:int, propertyName:String):void {
			var data:Object = _collection[index % _collectionLength];
			object[propertyName] = data;
		}

		public function finish():void {
			if(_openSubTrees != 0) {
				throw new Error("The number of calls to 'containing' and 'end' do not match");
			}

			_isUnfinished = false;
		}


		public function get setToThe():ItemToUse {
			return this;
		}


		public function value(value:*):BlockContent$InstanceModification {
			applyToAllObjects(setProperty, _instancePropertyName, value);
			return this;
		}


		public function withTheName(name:String):BlockContent$InstanceModification {
			createDelayedInstanceIfNeeded();
			applyToAllObjects(setProperty, "name", name);
			return this;
		}


		private function setProperty(object:DisplayObject, index:int, propertyName:String, value:*):void {
			object[propertyName] = value;
		}

		internal function valueExternal(value:*):void {
			applyToAllObjects(setProperty, _instancePropertyName, value);
		}

		internal function set instancePropertyName(value:String):void {
			_instancePropertyName = value;
		}

		internal function itemPropertyExternal(propertyName:String):void {
			applyToAllObjects(setPropertyOnObject, _instancePropertyName, propertyName);
		}

		internal function itemExternal():void {
			applyToAllObjects(setPropertyOnObjectToInstance, _instancePropertyName);
		}


		private function initializePreviousElement():void {
			if(_initFunction == null) {
				return;
			}
			applyToAllObjects(executeInitFunction, _initFunction);
			_initFunction = null;
		}


		private function executeInitFunction(element:DisplayObject, index:int, initFunc:Function):void {
			initFunc.call(element, element);
		}

		public function withTheInitializationFunction(initFunction:Function):InstanceModification {
			_initFunction = initFunction;
			return this;
		}
	}
}
