package net.wooga.displaytreebuilder.grammar {
	import net.wooga.selectors.AbstractSelectorFactory;

	public interface SelectorFeatures {

		function withTheId(id:String):BlockContent$InstanceModification;
		function withTheClasses(...classes:Array):BlockContent$InstanceModification;
		function withASelectorAdapterFrom(selectorFactory:AbstractSelectorFactory):BlockContent$InstanceModification;
	}
}
