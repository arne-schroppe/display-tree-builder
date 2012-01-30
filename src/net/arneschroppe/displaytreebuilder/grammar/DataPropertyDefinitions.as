package net.arneschroppe.displaytreebuilder.grammar {
	public interface DataPropertyDefinitions {
		function itemProperty(propertyName:String):BuildInstructionOrNameOrBlockStartOrSetProperty;
		function get item():BuildInstructionOrNameOrBlockStartOrSetProperty;
	}
}
