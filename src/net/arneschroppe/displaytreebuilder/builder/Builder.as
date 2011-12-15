package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import net.arneschroppe.displaytreebuilder.grammar.Add;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstruction;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrNameOrBlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuildInstructionOrStop;
	import net.arneschroppe.displaytreebuilder.grammar.BuilderLang;

	public class Builder implements BuilderLang, Add,  BlockStart, BuildInstruction, BuildInstructionOrStop, BuildInstructionOrNameOrBlockStart {

		private var _currentContainer:DisplayObjectContainer;
		private var _currentObject:DisplayObject;

		private var _nextCount:int;

		public function startWith(object:DisplayObject):BlockStart {
			_currentObject = object;
			_nextCount = 1;
			return this;
		}

		public function add(Type:Class):BuildInstructionOrNameOrBlockStart {

			for(var i:int = 0; i < _nextCount; ++i) {
				var instance:DisplayObject = new Type();
				_currentContainer.addChild(instance);
				_currentObject = instance;
			}

			_nextCount = 1;

			return this;
		}

		public function get begin():BuildInstruction {
			_currentContainer = _currentObject as DisplayObjectContainer;
			return this;
		}

		public function times(count:int):Add {
			_nextCount = count;
			return this;
		}

		public function get end():BuildInstructionOrStop {
			_currentContainer = _currentContainer.parent;
			return this;
		}

		public function stop():void {
		}

		public function withName(name:String):BuildInstruction {
			_currentObject.name = name;
			return this;
		}
	}
}
