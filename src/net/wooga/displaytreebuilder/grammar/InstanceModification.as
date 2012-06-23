package net.wooga.displaytreebuilder.grammar {
	import net.wooga.displaytreebuilder.grammar.ClassAndId;

	public interface InstanceModification extends BlockStart, ClassAndId, NameProperty, CollectionProperty, Storage, BlockEnd, BlockContent, DataDefinition {
		
	}
}
