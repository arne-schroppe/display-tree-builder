package net.arneschroppe.displaytreebuilder.grammar {
	public interface BuildInstructionOrBlockStart {

		function add(type:Class):BuildInstructionOrNameOrStoreInstanceOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function get begin():BuildInstruction;

	}
}
