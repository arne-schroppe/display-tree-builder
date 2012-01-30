package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrNameOrStoreInstanceOrBlockStart {

		function a(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function an(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function theInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;
		function finish():void;

		function withTheName(name:String):BuildInstructionOrBlockStart;
		function whichWillBeStoredIn(instances:Array):BuildInstructionOrNameOrBlockStart;

		function get containing():BuildInstruction;

	}
}
