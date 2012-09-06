package net.wooga.displaytreebuilder.grammar.datadefinition {
	import net.wooga.displaytreebuilder.grammar.datadefinition.singlevalue._setToThe__DataDef_SingleValue;

	public interface CollectionProperty__DataDef {
		function withTheProperty(propertyName:String):_setToThe__DataDef_SingleValue
		function withTheMethod(methodName:String):_calledWith__DataDef
		function get constructedWith():DataArgument__DataDef$BlockContent$BlockStart;
	}
}
