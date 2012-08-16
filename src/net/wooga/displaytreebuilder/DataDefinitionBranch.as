package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.wooga.displaytreebuilder.grammar.BlockContent;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Finish;
	import net.wooga.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Property;
	import net.wooga.displaytreebuilder.grammar.InstanceModification;
	import net.wooga.displaytreebuilder.grammar.Instantiation;
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.CtorArgument__DataDef$BlockContent$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.ItemToUse__DataDef;
	import net.wooga.displaytreebuilder.grammar.datadefinition._setToThe__DataDef;
	import net.wooga.displaytreebuilder.values.DataItem;
	import net.wooga.displaytreebuilder.values.DataItemProperty;

	internal class DataDefinitionBranch implements CtorArgument__DataDef$BlockContent$BlockStart, BlockContent$CollectionProperty__DataDef$BlockStart, _setToThe__DataDef, ItemToUse__DataDef {
		private var _originalObject:TreeBuilder;

		public function DataDefinitionBranch(originalObject:TreeBuilder) {
			_originalObject = originalObject;
		}


		public function withTheProperty(propertyName:String):_setToThe__DataDef {
			_originalObject.withTheProperty(propertyName);
			return this;
		}


		public function get setToThe():ItemToUse__DataDef {
			return this;
		}

		public function itemProperty(propertyName:String):BlockContent$CollectionProperty__DataDef$BlockStart {
			_originalObject.setValueForCurrentProperty(new DataItemProperty(propertyName));
			return this;
		}

		public function get item():BlockContent$CollectionProperty__DataDef$BlockStart {
			_originalObject.setValueForCurrentProperty(new DataItem());
			return this;
		}

		public function value(value:*):BlockContent$CollectionProperty__DataDef$BlockStart {
			_originalObject.value(value);
			return this;
		}


		public function times(count:int):Instantiation {
			return _originalObject.times(count);
		}

		public function theInstance(instance:DisplayObject):BlockContent$Property {
			return _originalObject.theInstance(instance);
		}

		public function a(type:Class):InstanceModification {
			return _originalObject.a(type);
		}

		public function an(type:Class):InstanceModification {
			return _originalObject.an(type);
		}

		public function get end():BlockContent$Finish {
			return _originalObject.end;
		}


		public function get containing():BlockContent {
			return _originalObject.containing;
		}

		public function withTheInitializationFunction(initFunction:Function):InstanceModification {
			return _originalObject.withTheInitializationFunction(initFunction);
		}

		public function get constructed():CtorArgument__DataDef$BlockContent$BlockStart {
			_originalObject.constructed;
			return this;
		}

		public function withArg(ctorArgument:*):CtorArgument__DataDef$BlockContent$BlockStart {
			_originalObject.withArg(ctorArgument);
			return this;
		}

		public function get withTheItem():CtorArgument__DataDef$BlockContent$BlockStart {
			_originalObject.addConstructorArgument(new DataItem());
			return this;
		}
	}
}
