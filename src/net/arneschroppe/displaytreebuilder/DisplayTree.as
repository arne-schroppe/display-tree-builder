package net.arneschroppe.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.arneschroppe.displaytreebuilder.builder.TreeBuilder;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BuilderLang;

	public class DisplayTree implements BuilderLang {

		private var _builder:TreeBuilder;

		public function DisplayTree() {
			_builder = new TreeBuilder();
		}


		public function hasA(object:DisplayObject):BlockStart {
			return _builder.hasA(object);
		}

		public function hasAn(object:DisplayObject):BlockStart {
			return hasA(object);
		}
	}
}
