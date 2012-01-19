package net.arneschroppe.displaytreebuilder.grammar {
	import flash.display.DisplayObject;

	public interface BuilderLang {
		function startWith(object:DisplayObject, shouldCheckUnfinishedStatements:Boolean=true):BlockStart;
	}
}
