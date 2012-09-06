package net.wooga.displaytreebuilder.grammar.datadefinition {
	import net.wooga.displaytreebuilder.grammar.BlockEnd;

	public interface InstanceModification__DataDef extends BlockContent$BlockStart, CollectionProperty__DataDef, BlockEnd, InitializationFunction__DataDef {

		function withTheName(name:String):InstanceModification__DataDef;
		function whichWillBeStoredIn(collection:Array):InstanceModification__DataDef;
	}
}
