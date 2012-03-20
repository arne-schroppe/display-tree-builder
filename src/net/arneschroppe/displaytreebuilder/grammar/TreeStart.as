package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface TreeStart {
		function uses(object:DisplayObject):BlockStart;
	}
}
