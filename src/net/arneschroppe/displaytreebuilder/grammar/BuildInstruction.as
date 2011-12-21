package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstruction {

		function add(type:Class):BuildInstructionOrNameOrBlockStart;
		function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;
		function usElementsIn(collection:*):AddObjects

		function get end():BuildInstructionOrStop;

	}
}
