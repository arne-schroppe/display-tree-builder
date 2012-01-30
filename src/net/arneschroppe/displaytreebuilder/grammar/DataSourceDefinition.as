package net.arneschroppe.displaytreebuilder.grammar {
	public interface DataSourceDefinition {

		function forEveryItemIn(collection:*):BuildInstructionOrNameOrBlockStartOrSetProperty;
	}
}
