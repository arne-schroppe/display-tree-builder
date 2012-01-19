package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuildInstructionOrNameOrBlockStartOrSetProperty {
		function add(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function addInstance(object:DisplayObject):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;
		function finish():void;

		function withName(name:String):BuildInstructionOrBlockStart;

		function get begin():BuildInstruction;

		function setObjectProperty(propertyName:String):FromField;

	}
}
