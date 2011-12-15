package net.arneschroppe.displaytreebuilder.grammar {
	public interface BuildInstructionOrStop {

		function add(type:Class):BuildInstructionOrNameOrBlockStart;

		function times(count:int):Add;

		function get end():BuildInstructionOrStop;

		function stop():void;
	}
}
