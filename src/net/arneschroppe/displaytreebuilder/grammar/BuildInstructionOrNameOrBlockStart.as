package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrNameOrBlockStart {

		function add(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function withName(name:String):BuildInstructionOrBlockStart;

		function get begin():BuildInstruction;

	}
}
