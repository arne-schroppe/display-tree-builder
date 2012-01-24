package net.arneschroppe.displaytreebuilder.grammar {
	public interface FromField {
		function isSetToItemField(propertyName:String):BuildInstructionOrNameOrBlockStartOrSetProperty;
		function get isSetToTheRespectiveItem():BuildInstructionOrNameOrBlockStartOrSetProperty;
	}
}
