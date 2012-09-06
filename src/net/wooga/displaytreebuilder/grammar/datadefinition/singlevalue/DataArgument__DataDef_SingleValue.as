package net.wooga.displaytreebuilder.grammar.datadefinition.singlevalue {
	import net.wooga.displaytreebuilder.grammar.datadefinition.*;

	public interface DataArgument__DataDef_SingleValue {
		function theValue(ctorArgument:*):CollectionProperty__DataDef$BlockContent$BlockStart;
		function get theItem():CollectionProperty__DataDef$BlockContent$BlockStart;
		function theItemProperty(propertyName:String):CollectionProperty__DataDef$BlockContent$BlockStart;
	}
}
