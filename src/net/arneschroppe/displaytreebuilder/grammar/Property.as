package net.arneschroppe.displaytreebuilder.grammar {
	public interface Property {
		function withTheName(name:String):BlockContent$InstanceModification;
		function withTheProperty(propertyName:String):PropertyValue;
	}
}
