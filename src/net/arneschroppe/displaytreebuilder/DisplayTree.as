package net.arneschroppe.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.arneschroppe.displaytreebuilder.TreeBuilder;
	import net.arneschroppe.displaytreebuilder.grammar.BlockStart;

	import net.arneschroppe.displaytreebuilder.grammar.TreeStart;


	public class DisplayTree implements TreeStart {

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


		public function set isCheckingUnfinishedStatements(value:Boolean):void {
			_builder.isCheckingUnfinishedStatements = value;
		}

		public function get isCheckingUnfinishedStatements():Boolean {
			return _builder.isCheckingUnfinishedStatements;
		}
	}
}
