package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface DisplayTreeStart {
		function hasA(object:DisplayObject):BlockStart;
		function hasAn(object:DisplayObject):BlockStart;
	}
}
