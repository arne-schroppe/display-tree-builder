package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstruction {

		function add(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;
		function useItemsIn(collection:*):AddObjects

		function get end():BuildInstructionOrStop;
		function finish():void;
	}
}
