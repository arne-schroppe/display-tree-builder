package net.wooga.displaytreebuilder.grammar.datadefinition {
	public interface ItemToUse__DataDef {
		function itemProperty(propertyName:String):BlockContent$CollectionProperty__DataDef$BlockStart;
		function get item():BlockContent$CollectionProperty__DataDef$BlockStart;
		function value(value:*):BlockContent$CollectionProperty__DataDef$BlockStart;
	}
}
