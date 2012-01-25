package net.arneschroppe.displaytreebuilder.grammar {
	public interface ToField {
		function isUsedAsTheProperty(propertyName:String):BuildInstructionOrNameOrBlockStartOrSetAdditionalProperty;
	}
}
