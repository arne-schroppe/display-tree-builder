package net.arneschroppe.displaytreebuilder.grammar {
	public interface FromField {
		function toItemField(propertyName:String):BuildInstructionOrNameOrBlockStartOrSetProperty;
		function get toRespectiveItem():BuildInstructionOrNameOrBlockStartOrSetProperty;
	}
}
