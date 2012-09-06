package net.wooga.displaytreebuilder {
	import net.wooga.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.DataArgument;
	import net.wooga.displaytreebuilder.grammar.DataArgument$BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.singlevalue.DataArgument__SingleValue;
	import net.wooga.displaytreebuilder.grammar.singlevalue._setToThe__SingleValue;

	internal class SingleValueBranch implements _setToThe__SingleValue, DataArgument__SingleValue{

		private var _originalObject:TreeBuilder;

		public function SingleValueBranch(originalObject:TreeBuilder) {
			_originalObject = originalObject;
		}

		public function get setTo():DataArgument__SingleValue {
			return this;
		}

		public function theValue(value:*):BlockContent$InstanceModification {
			_originalObject.theValue(value);
			return _originalObject;
		}
	}
}
