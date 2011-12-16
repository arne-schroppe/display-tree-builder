package net.arneschroppe.displaytreebuilder.grammar {
	public interface BuildInstructionOrNameOrBlockStart {

		function add(type:Class):BuildInstructionOrNameOrBlockStart

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function withName(name:String):BuildInstructionOrBlockStart;

		function get begin():BuildInstruction;

	}
}
