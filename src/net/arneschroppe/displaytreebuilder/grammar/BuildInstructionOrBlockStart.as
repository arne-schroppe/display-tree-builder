package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrBlockStart {

		function a(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function theInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function get containing():BuildInstruction;

	}
}
