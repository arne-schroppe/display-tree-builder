package net.arneschroppe.displaytreebuilder.grammar {
	public interface FromField {
		function fromDataField(propertyName:String):BuildInstructionOrNameOrBlockStartOrSetProperty;
	}
}
