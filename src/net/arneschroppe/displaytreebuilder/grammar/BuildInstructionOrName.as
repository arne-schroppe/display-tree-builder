package net.arneschroppe.displaytreebuilder.grammar {
	public interface BuildInstructionOrName {
		function add(type:Class):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function withName(name:String):BuildInstruction;
	}
}
