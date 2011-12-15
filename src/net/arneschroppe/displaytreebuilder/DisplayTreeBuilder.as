package net.arneschroppe.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.arneschroppe.displaytreebuilder.builder.Builder;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuilderLang;

	public class DisplayTreeBuilder implements BuilderLang {

		private var _builder:Builder;

		public function DisplayTreeBuilder() {
			_builder = new Builder();
		}


		public function startWith(object:DisplayObject):BlockStart {
			return _builder.startWith(object);
		}
	}
}
