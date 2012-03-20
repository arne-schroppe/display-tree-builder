package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BlockContent extends Instantiation, BlockEnd {

		function times(count:int):Instantiation;
		function theInstance(instance:DisplayObject):BlockContent$Property;

	}
}
