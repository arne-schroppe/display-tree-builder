package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import net.arneschroppe.displaytreebuilder.grammar.BlockContent;
	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$Property;

	import net.arneschroppe.displaytreebuilder.grammar.InstanceModification;

	import net.arneschroppe.displaytreebuilder.grammar.PropertyValue;

	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$CollectionProperty;
	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$Finish;
	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.DataDefinition;
	import net.arneschroppe.displaytreebuilder.grammar.DisplayTree;
	import net.arneschroppe.displaytreebuilder.grammar.Instantiation;
	import net.arneschroppe.displaytreebuilder.grammar.Property;
	import net.arneschroppe.displaytreebuilder.grammar.Storage;
	import net.arneschroppe.displaytreebuilder.grammar._finish;
	import net.arneschroppe.displaytreebuilder.grammar._instanceProperty;
	import net.arneschroppe.displaytreebuilder.grammar.ItemToUse;
	import net.arneschroppe.displaytreebuilder.grammar._setToThe;

	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	public class TreeBuilder implements BlockContent$Property, _finish, _instanceProperty, ItemToUse, _setToThe, BlockContent$CollectionProperty, BlockContent$Finish, BlockContent$InstanceModification, BlockStart, DataDefinition, DisplayTree, Instantiation, Property, PropertyValue, Storage {

		private var _currentContainersStack:Array = [[]];
		private var _currentObjectsStack:Array = [];

		private var _count:int;
		
		private var _collection:*;
		private var _objectTypeCreatedFromData:Class;
		
		private var _instancePropertyName:String;

		private var _isUnfinished:Boolean = false;

		private var _openSubTrees:int;

		private var _isCheckingUnfinishedStatements:Boolean = true;
		
		private var _setPropertyName:String = "";



		public function set isCheckingUnfinishedStatements(value:Boolean):void {
			_isCheckingUnfinishedStatements = value;
		}

		public function get isCheckingUnfinishedStatements():Boolean {
			return _isCheckingUnfinishedStatements;
		}

		public function hasA(object:DisplayObject):BlockStart {
			if(_isCheckingUnfinishedStatements && _isUnfinished) {
				throw new Error("Previous expression was unfinished. Add the 'unfinished' keyword")
			}
			_openSubTrees = 0;
			_isUnfinished = true;

			_currentObjectsStack = [[object]];
			_count = 1;
			return this;
		}

		public function hasAn(object:DisplayObject):BlockStart {
			return hasA(object);
		}


		private function get currentContainers():Array {
			return _currentContainersStack[_currentContainersStack.length - 1];
		}


		private function get currentObjects():Array {
			return _currentObjectsStack[_currentObjectsStack.length - 1];
		}


		public function a(Type:Class):InstanceModification {
			clearCurrentObjects();
			loopOnContainers(addClassInternal, [Type]);
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
			var instance:DisplayObject = new Type();
			addInstanceInternal(container, index, instance);
		}


		private function addInstanceInternal(container:DisplayObjectContainer, index:int, instance:DisplayObject):void {
			container.addChild(instance);
			currentObjects.push(instance);
		}


		public function get containing():BlockContent {
			_openSubTrees++;
			_currentContainersStack.push(currentObjects.concat());
			_currentObjectsStack.push([]);
			return this;
		}


		public function times(count:int):Instantiation {
			_count = count;
			return this;
		}


		public function get end():BlockContent$Finish {
			_openSubTrees--;
			_currentContainersStack.pop();
			_currentObjectsStack.pop();

			return this;
		}


		public function theInstance(object:DisplayObject):BlockContent$Property {
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


		public function forEveryItemIn(collection:*):BlockContent$CollectionProperty {
			if(collection is IIterable) {
				storeCollectionInArray(collection);
			}
			else if(collection is IIterator) {
				storeIteratorInArray(collection);
			}
			else {
				_collection = collection;
			}

			_count = _collection.length;
			loopOnContainers(addClassInternal, [_objectTypeCreatedFromData]);

			return this;
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
		}


		public function anInstanceOf(type:Class):DataDefinition {

			_objectTypeCreatedFromData = type;

			return this;
		}

		public function get withThe():_instanceProperty {
			return this;
		}




		public function instanceProperty(instancePropertyName:String):_setToThe {
			_instancePropertyName = instancePropertyName;
			return this;
		}



		public function get item():BlockContent$CollectionProperty {
			applyToAllObjects(setFieldOnObjectToInstance, _instancePropertyName);
			return this;
		}




		public function itemProperty(propertyName:String):BlockContent$CollectionProperty {
			applyToAllObjects(setFieldOnObject,_instancePropertyName, propertyName);
			return this;
		}


		public function whichWillBeStoredIn(instances:Array):BlockContent$InstanceModification {
			for each(var instance:* in currentObjects) {
				instances.push(instance);
			}

			return this;
		}

		private function setFieldOnObject(object:Object, index:int, propertyName:String, dataFieldName:String):void {
			var data:Object = _collection[index];
			object[propertyName] = data[dataFieldName];
		}

		private function setFieldOnObjectToInstance(object:Object, index:int, propertyName:String):void {
			var data:Object = _collection[index];
			object[propertyName] = data;
		}

		public function finish():void {
			if(_openSubTrees != 0) {
				throw new Error("The numbers of begin's and end's are not matching");
			}
			
			_isUnfinished = false;
		}



		public function get setToThe():ItemToUse {
			return this;
		}

		

		public function withTheProperty(propertyName:String):PropertyValue {
			_setPropertyName = propertyName;
			return this;
		}

		public function setTo(value:*):BlockContent$InstanceModification {
			applyToAllObjects(setProperty, _setPropertyName, value);
			return this;
		}


		public function withTheName(name:String):BlockContent$InstanceModification {
			applyToAllObjects(setProperty, "name", name);
			return this;
		}


		private function setProperty(object:DisplayObject, index:int, propertyName:String, value:*):void {
			object[propertyName] = value;
		}


	}
}
