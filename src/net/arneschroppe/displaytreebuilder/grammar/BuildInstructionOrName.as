package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrName {
		function a(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function an(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function theInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart
		
		function times(count:int):Add;

		function get end():BuildInstructionOrStop;
		function finish():void;

		function withName(name:String):BuildInstructionOrBlockStart;
	}
}
