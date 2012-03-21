package net.arneschroppe.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.arneschroppe.displaytreebuilder.grammar.BlockContent;

	import net.arneschroppe.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;
	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$Finish;
	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.arneschroppe.displaytreebuilder.grammar.BlockContent$Property;
	import net.arneschroppe.displaytreebuilder.grammar.InstanceModification;
	import net.arneschroppe.displaytreebuilder.grammar.Instantiation;
	import net.arneschroppe.displaytreebuilder.grammar.datadefinition.ItemToUse__DataDef;
	import net.arneschroppe.displaytreebuilder.grammar.datadefinition._setToThe__DataDef;

	internal class DataDefinitionBranch implements BlockContent$CollectionProperty__DataDef$BlockStart, _setToThe__DataDef, ItemToUse__DataDef {
		private var _originalObject:TreeBuilder;

		public function DataDefinitionBranch(originalObject:TreeBuilder) {
			_originalObject = originalObject;
		}


		public function withTheProperty(propertyName:String):_setToThe__DataDef {
			_originalObject.createDelayedInstanceIfNeeded();
			_originalObject.instancePropertyName = propertyName;
			return this;
		}


		public function get setToThe():ItemToUse__DataDef {
			return this;
		}

		public function itemProperty(propertyName:String):BlockContent$CollectionProperty__DataDef$BlockStart {
			_originalObject.itemPropertyExternal(propertyName);
			return this;
		}

		public function get item():BlockContent$CollectionProperty__DataDef$BlockStart {
			_originalObject.itemExternal();
			return this;
		}

		public function value(value:*):BlockContent$InstanceModification {
			return _originalObject.value(value);
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

	}
}
