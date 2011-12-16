package net.arneschroppe.displaytreebuilder.grammar {
	public interface AddObjects {

		function toAddObjectsOfType(type:Class):BuildInstructionOrNameOrBlockStartOrSetProperty;
	}
}
