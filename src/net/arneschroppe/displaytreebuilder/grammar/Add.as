package net.arneschroppe.displaytreebuilder.grammar {
	public interface Add {
		function a(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
		function an(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;
	}
}
