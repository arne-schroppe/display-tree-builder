package net.wooga.displaytreebuilder {
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.CollectionProperty__DataDef$BlockContent$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.singlevalue.DataArgument__DataDef_SingleValue;
	import net.wooga.displaytreebuilder.grammar.datadefinition.singlevalue._setToThe__DataDef_SingleValue;

	internal class DataDefinitionSingleValueBranch implements _setToThe__DataDef_SingleValue, DataArgument__DataDef_SingleValue{

		private var _originalObject:DataDefinitionBranch;

		public function DataDefinitionSingleValueBranch(originalObject:DataDefinitionBranch) {
			_originalObject = originalObject;
		}

		public function get setTo():DataArgument__DataDef_SingleValue{
			return this;
		}

		public function theValue(value:*):CollectionProperty__DataDef$BlockContent$BlockStart {
			_originalObject.theValue(value);
			return _originalObject;
		}

		public function get theItem():CollectionProperty__DataDef$BlockContent$BlockStart {
			_originalObject.theItem;
			return _originalObject;
		}

		public function theItemProperty(propertyName:String):CollectionProperty__DataDef$BlockContent$BlockStart {
			_originalObject.theItemProperty(propertyName);
			return _originalObject;
		}
	}
}
