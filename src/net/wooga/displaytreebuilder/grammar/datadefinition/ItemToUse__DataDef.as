package net.wooga.displaytreebuilder.grammar.datadefinition {
	import net.wooga.displaytreebuilder.grammar.*;
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;

	public interface ItemToUse__DataDef {
		function itemProperty(propertyName:String):BlockContent$CollectionProperty__DataDef$BlockStart;
		function get item():BlockContent$CollectionProperty__DataDef$BlockStart;
		function value(value:*):BlockContent$InstanceModification;
	}
}
