package net.arneschroppe.displaytreebuilder.grammar {
	import net.arneschroppe.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;

	public interface DataDefinition {
		function forEveryItemIn(collection:*):BlockContent$CollectionProperty__DataDef$BlockStart;
	}
}
