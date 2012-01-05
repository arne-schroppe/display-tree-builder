package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrStop {

		function add(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;

		function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

	}
}
