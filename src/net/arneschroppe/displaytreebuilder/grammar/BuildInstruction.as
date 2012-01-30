package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstruction {

		function a(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function an(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function theInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;

		function anInstanceOf(type:Class):DataSourceDefinition;


		function get end():BuildInstructionOrStop;
		function finish():void;
	}
}
