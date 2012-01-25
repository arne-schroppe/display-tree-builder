package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import net.arneschroppe.displaytreebuilder.grammar.Add;
	import net.arneschroppe.displaytreebuilder.grammar.AddObjects;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstruction;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrBlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrNameOrBlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrNameOrBlockStartOrSetAdditionalProperty;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrNameOrBlockStartOrSetProperty;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrNameOrStoreInstanceOrBlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrStop;
	import net.arneschroppe.displaytreebuilder.grammar.BuilderLang;
	import net.arneschroppe.displaytreebuilder.grammar.PropertyDefinitions;
	import net.arneschroppe.displaytreebuilder.grammar.ToField;

	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	public class TreeBuilder implements BuildInstructionOrNameOrBlockStartOrSetAdditionalProperty, PropertyDefinitions, ToField, BuildInstructionOrNameOrStoreInstanceOrBlockStart, BuildInstructionOrNameOrBlockStartOrSetProperty, AddObjects, BuildInstructionOrBlockStart, BuilderLang, Add,  BlockStart, BuildInstruction, BuildInstructionOrStop, BuildInstructionOrNameOrBlockStart {

		private var _currentContainersStack:Array = [[]];
		private var _currentObjectsStack:Array = [];

		private var _count:int;
		private var _collection:*;
		
		private var _dataFieldName:String;

		private var _isUnfinished:Boolean = false;

		private var _openSubTrees:int;

		private var _isCheckingUnfinishedStatements:Boolean = true;



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


		public function a(Type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart {
			clearCurrentObjects();
			loopOnContainers(addClassInternal, [Type]);
			return this;
		}

		public function an(Type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart {
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


		public function get containing():BuildInstruction {
			_openSubTrees++;
			_currentContainersStack.push(currentObjects.concat());
			_currentObjectsStack.push([]);
			return this;
		}


		public function times(count:int):Add {
			_count = count;
			return this;
		}


		public function get end():BuildInstructionOrStop {
			_openSubTrees--;
			_currentContainersStack.pop();
			_currentObjectsStack.pop();

			return this;
		}


		public function theInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart {
			clearCurrentObjects();
			if(currentContainers.length > 1) {
				throw new Error("Cannot add an instance to several containers");
			}
			loopOnContainers(addInstanceInternal, [object]);
			return this;
		}



		public function withName(name:String):BuildInstructionOrBlockStart {
			applyToAllObjects(setName, name);
			return this;
		}


		private function setName(object:DisplayObject, index:int, name:String):void {
			object.name = name;
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


		public function theItemsIn(collection:*):AddObjects {
			if(collection is IIterable) {
				storeCollectionInArray(collection);
			}
			else if(collection is IIterator) {
				storeIteratorInArray(collection);
			}
			else {
				_collection = collection;
			}

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


		public function whichBecomeObjectsOfType(type:Class):BuildInstructionOrNameOrBlockStartOrSetProperty {
			_count = _collection.length;
			loopOnContainers(addClassInternal, [type]);

			return this;
		}

		public function get where():PropertyDefinitions {
			return this;
		}




		public function theItemField(dataFieldName:String):ToField {
			_dataFieldName = dataFieldName;
			return this;
		}



		public function get theRespectiveItem():ToField {
			_dataFieldName = null;
			return this;
		}


		public function isUsedAsTheProperty(propertyName:String):BuildInstructionOrNameOrBlockStartOrSetAdditionalProperty {
			if(_dataFieldName == null) {
				applyToAllObjects(setFieldOnObjectToInstance, propertyName);
			}
			else {
				applyToAllObjects(setFieldOnObject, propertyName, _dataFieldName);
			}

			return this;
		}


		public function whichWillBeStoredIn(instances:Array):BuildInstructionOrNameOrBlockStart {
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

	}
}
