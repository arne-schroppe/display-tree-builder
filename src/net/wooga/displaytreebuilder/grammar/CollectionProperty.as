package net.wooga.displaytreebuilder.grammar {
	import net.wooga.displaytreebuilder.grammar.singlevalue._setToThe__SingleValue;

	public interface CollectionProperty {
		function withTheProperty(propertyName:String):_setToThe__SingleValue;
		function withTheMethod(methodName:String):_calledWith;

		function get constructedWith():DataArgument$BlockContent$InstanceModification;

	}
}
