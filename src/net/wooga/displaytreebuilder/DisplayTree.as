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

		public function set isCheckingUnfinishedStatements(value:Boolean):void {
			_builder.isCheckingUnfinishedStatements = value;
		}

		public function get isCheckingUnfinishedStatements():Boolean {
			return _builder.isCheckingUnfinishedStatements;
		}
	}
}
