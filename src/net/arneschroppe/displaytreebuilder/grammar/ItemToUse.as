package net.arneschroppe.displaytreebuilder.grammar {
	public interface ItemToUse {
		function itemProperty(propertyName:String):BlockContent$CollectionProperty$BlockStart;
		function get item():BlockContent$CollectionProperty$BlockStart;
	}
}
