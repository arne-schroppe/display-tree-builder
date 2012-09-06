package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.wooga.displaytreebuilder.grammar.BlockContent;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Finish;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Property;
	import net.wooga.displaytreebuilder.grammar.InstanceModification;
	import net.wooga.displaytreebuilder.grammar.Instantiation;
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.CollectionProperty__DataDef$BlockContent$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.DataArgument__DataDef;
	import net.wooga.displaytreebuilder.grammar.datadefinition.DataArgument__DataDef$BlockContent$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.DataArgument__DataDef$CollectionProperty__DataDef$BlockContent$BlockStart;
	import net.wooga.displaytreebuilder.grammar.datadefinition.InstanceModification__DataDef;
	import net.wooga.displaytreebuilder.grammar.datadefinition._calledWith__DataDef;
	import net.wooga.displaytreebuilder.grammar.datadefinition.singlevalue._setToThe__DataDef_SingleValue;
	import net.wooga.displaytreebuilder.values.DataItem;
	import net.wooga.displaytreebuilder.values.DataItemProperty;

	internal class DataDefinitionBranch implements DataArgument__DataDef$CollectionProperty__DataDef$BlockContent$BlockStart, CollectionProperty__DataDef$BlockContent$BlockStart, DataArgument__DataDef$BlockContent$BlockStart, BlockContent$CollectionProperty__DataDef$BlockStart, _calledWith__DataDef {
		private var _originalObject:TreeBuilder;

		public function DataDefinitionBranch(originalObject:TreeBuilder) {
			_originalObject = originalObject;
		}


		public function withTheProperty(propertyName:String):_setToThe__DataDef_SingleValue {
			_originalObject.withTheProperty(propertyName);
			return new DataDefinitionSingleValueBranch(this);
		}

//		public function itemProperty(propertyName:String):BlockContent$CollectionProperty__DataDef$BlockStart {
//			_originalObject.addData(new DataItemProperty(propertyName));
//			return this;
//		}
//
//		public function get item():BlockContent$CollectionProperty__DataDef$BlockStart {
//			_originalObject.addData(new DataItem());
//			return this;
//		}

//		public function value(value:*):BlockContent$CollectionProperty__DataDef$BlockStart {
//			_originalObject.theValue(value);
//			return this;
//		}


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

		public function withTheInitializationFunction(initFunction:Function):InstanceModification__DataDef {
			_originalObject.withTheInitializationFunction(initFunction);
			return this;
		}

		public function get constructedWith():DataArgument__DataDef$BlockContent$BlockStart {
			_originalObject.constructedWith;
			return this;
		}

		public function theValue(ctorArgument:*):DataArgument__DataDef$CollectionProperty__DataDef$BlockContent$BlockStart {
			_originalObject.theValue(ctorArgument);
			return this;
		}

		public function get theItem():DataArgument__DataDef$CollectionProperty__DataDef$BlockContent$BlockStart {
			_originalObject.addData(new DataItem());
			return this;
		}

		public function theItemProperty(propertyName:String):DataArgument__DataDef$CollectionProperty__DataDef$BlockContent$BlockStart {
			_originalObject.addData(new DataItemProperty(propertyName));
			return this;
		}

		public function withTheMethod(methodName:String):_calledWith__DataDef {
			_originalObject.withTheMethod(methodName);
			return this;
		}

		public function get calledWith():DataArgument__DataDef {
			_originalObject.calledWith;
			return this;
		}

		public function get calledWithNoParams():BlockContent$CollectionProperty__DataDef$BlockStart {
			_originalObject.calledWithNoParams;
			return this;
		}

		public function withTheName(name:String):InstanceModification__DataDef {
			_originalObject.withTheName(name);
			return this;
		}

		public function whichWillBeStoredIn(collection:Array):InstanceModification__DataDef {
			_originalObject.whichWillBeStoredIn(collection);
			return this;
		}
	}
}
