package net.arneschroppe.displaytreebuilder.grammar {
	public interface Instantiation {
		function a(type:Class):InstanceModification;
		function an(type:Class):InstanceModification;
		function anInstanceOf(type:Class):DataDefinition;
	}
}
