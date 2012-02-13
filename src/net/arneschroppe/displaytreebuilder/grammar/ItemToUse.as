package net.arneschroppe.displaytreebuilder.grammar {
	public interface ItemToUse {
		function itemProperty(propertyName:String):BlockContent$CollectionProperty;
		function get item():BlockContent$CollectionProperty;
	}
}
