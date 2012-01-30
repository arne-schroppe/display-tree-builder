package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrNameOrBlockStartOrSetProperty {
		function a(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function an(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;

		function theInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;
		function finish():void;

		function withTheName(name:String):BuildInstructionOrBlockStart;

		function get containing():BuildInstruction;

		function get withThe():PropertyDefinitions;

	}
}
