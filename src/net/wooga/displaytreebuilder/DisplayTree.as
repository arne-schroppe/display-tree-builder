package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.wooga.displaytreebuilder.TreeBuilder;
	import net.wooga.displaytreebuilder.grammar.BlockStart;

	import net.wooga.displaytreebuilder.grammar.TreeStart;


	public class DisplayTree implements TreeStart {

		private var _builder:TreeBuilder;

		public function DisplayTree() {
			_builder = new TreeBuilder();
		}


		public function uses(object:DisplayObject):BlockStart {
			return _builder.uses(object);
		}

	}
}
