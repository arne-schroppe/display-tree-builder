package net.wooga.displaytreebuilder.grammar {
	public interface CollectionProperty {
		function withTheProperty(propertyName:String):_setToThe;
		function withTheMethod(methodName:String):_calledWithThe;

		function get constructedWith():CtorArgument$BlockContent$InstanceModification;

	}
}
