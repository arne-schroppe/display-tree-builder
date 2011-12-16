package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrNameOrBlockStartOrSetProperty {
		function add(type:Class):BuildInstructionOrNameOrBlockStart
		function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function withName(name:String):BuildInstructionOrBlockStart;

		function get begin():BuildInstruction;

		function setProperty(propertyName:String):BuildInstructionOrNameOrBlockStartOrFromField;
	}
}
