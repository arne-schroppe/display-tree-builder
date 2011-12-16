package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import net.arneschroppe.displaytreebuilder.grammar.Add;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstruction;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrBlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrNameOrBlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrStop;
	import net.arneschroppe.displaytreebuilder.grammar.BuilderLang;

	public class Builder implements BuildInstructionOrBlockStart, BuilderLang, Add,  BlockStart, BuildInstruction, BuildInstructionOrStop, BuildInstructionOrNameOrBlockStart {

		private var _currentContainersStack:Array = [[]];
		private var _currentObjectsStack:Array = [];

		private var _nextCount:int;


		public function startWith(object:DisplayObject):BlockStart {
			_currentObjectsStack = [[object]];
			_nextCount = 1;
			return this;
		}

		private function get currentContainers():Array {
			return _currentContainersStack[_currentContainersStack.length - 1];
		}

		private function get currentObjects():Array {
			return _currentObjectsStack[_currentObjectsStack.length - 1];
		}

		public function add(Type:Class):BuildInstructionOrNameOrBlockStart {
			clearCurrentObjects();
			loopOnContainers(addClassInternal, [Type]);
			return this;
		}

		private function clearCurrentObjects():void {
			_currentObjectsStack.pop();
			_currentObjectsStack.push([]);
		}


		private function addClassInternal(container:DisplayObjectContainer, Type:Class):void {
			var instance:DisplayObject = new Type();
			addInstanceInternal(container, instance);
		}

		private function addInstanceInternal(container:DisplayObjectContainer, instance:DisplayObject):void {
			container.addChild(instance);
			currentObjects.push(instance);
		}


		public function get begin():BuildInstruction {
			_currentContainersStack.push(currentObjects.concat());
			_currentObjectsStack.push([]);
			return this;
		}


		public function times(count:int):Add {
			_nextCount = count;
			return this;
		}


		public function get end():BuildInstructionOrStop {

			_currentContainersStack.pop();
			_currentObjectsStack.pop();

			return this;
		}

		public function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart {
			clearCurrentObjects();
			loopOnContainers(addInstanceInternal, [object]);
			return this;
		}

		public function finish():void {
		}


		public function withName(name:String):BuildInstructionOrBlockStart {
			applyToAllObjects(setName, name);
			return this;
		}


		private function setName(object:DisplayObject, name:String):void {
			object.name = name;
		}


		private function loopOnContainers(method:Function, arguments:Array):void {

			var args:Array = arguments.concat();
			args.unshift(method);
			for(var i:int = 0; i < _nextCount; ++i) {
				applyToAllContainers.apply(this, args);
			}

			_nextCount = 1;
		}


		private function applyToAllObjects(method:Function, ...rest):void {
			for each (var object:DisplayObject in currentObjects) {
				var actualArguments:Array = rest.concat();
				actualArguments.unshift(object);
				method.apply(this, actualArguments);
			}
		}

		private function applyToAllContainers(method:Function, ...rest):void {
			for each (var container:DisplayObjectContainer in currentContainers) {
				var actualArguments:Array = rest.concat();
				actualArguments.unshift(container);
				method.apply(this, actualArguments);
			}
		}


	}
}
