package net.arneschroppe.displaytreebuilder.grammar {
	public interface BuildInstruction {

		function add(type:Class):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

	}
}
