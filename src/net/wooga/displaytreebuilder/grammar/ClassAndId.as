package net.wooga.displaytreebuilder.grammar {
	public interface ClassAndId {

		function withTheId(id:String):BlockContent$InstanceModification;
		function withTheClasses(...classes:Array):BlockContent$InstanceModification;
	}
}
