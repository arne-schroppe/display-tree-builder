package net.wooga.displaytreebuilder.grammar {
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;

	public interface DataDefinition {
		function forEveryItemIn(collection:*):BlockContent$CollectionProperty__DataDef$BlockStart;
	}
}
