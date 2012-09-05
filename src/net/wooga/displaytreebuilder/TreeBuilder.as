package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.wooga.displaytreebuilder.grammar.BlockContent;
	import net.wooga.displaytreebuilder.grammar.BlockContent$CollectionProperty$BlockStart;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Finish;
	import net.wooga.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Property;
	import net.wooga.displaytreebuilder.grammar.BlockStart;
	import net.wooga.displaytreebuilder.grammar.DataArgument;
	import net.wooga.displaytreebuilder.grammar.DataArgument$BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.DataDefinition;
	import net.wooga.displaytreebuilder.grammar.InstanceModification;
	import net.wooga.displaytreebuilder.grammar.Instantiation;
	import net.wooga.displaytreebuilder.grammar.NameProperty;
	import net.wooga.displaytreebuilder.grammar.Storage;
	import net.wooga.displaytreebuilder.grammar.TreeStart;
	import net.wooga.displaytreebuilder.grammar._calledWith;
	import net.wooga.displaytreebuilder.grammar._finish;
	import net.wooga.displaytreebuilder.grammar.singlevalue._setToThe__SingleValue;
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;
	import net.wooga.displaytreebuilder.treenodes.ITreeNode;
	import net.wooga.displaytreebuilder.treenodes.InstanceTreeNode;
	import net.wooga.displaytreebuilder.treenodes.TypeTreeNode;
	import net.wooga.displaytreebuilder.values.IValue;
	import net.wooga.displaytreebuilder.values.StaticValue;

	//TODO (arneschroppe 04/09/2012) unify values for constructors and the rest.
	// syntax should be withTheProperty(xyz).setTo.theValue(123), a(Sprite).constructedWith.theValue(123), withTheMethod(addStuff).calledWith.theValue(123)
	internal class TreeBuilder implements DataArgument$BlockContent$InstanceModification, BlockContent$Property, _finish, _calledWith, BlockContent$CollectionProperty$BlockStart, BlockContent$Finish, BlockContent$InstanceModification, BlockStart, DataDefinition, TreeStart, Instantiation, NameProperty, Storage {


		private var _rootTreeNode:InstanceTreeNode;
		private var _currentContainer:ITreeNode;
		private var _lastAddedNode:ITreeNode;

		private var _countForNextNode:int;


		private var _isAddingCtorParams:Boolean;
		private var _property:String;
		private var _method:String;

		private var _numberOfOpenSubBranches:int;
		private var _isStarted:Boolean;

		public function uses(object:DisplayObject):BlockStart {
			checkPreviousStart();
			reset();
			_rootTreeNode = new InstanceTreeNode(object);
			_lastAddedNode = _rootTreeNode;

			return this;
		}

		private function checkPreviousStart():void {
			if(_isStarted) {
				throw new Error("Previous tree was not finished (needs 'finish' keyword)");
			}
		}

		//TODO (arneschroppe 06/08/2012) test using a tree builder instance several times
		private function reset():void {
			_countForNextNode = 1;
			_property = null;
			_numberOfOpenSubBranches = 0;
			_isStarted = true;
		}



		public function a(Type:Class):InstanceModification {
			var node:TypeTreeNode = new TypeTreeNode();
			node.type = Type;

			setStoredCount(node);

			_currentContainer.addChild(node);

			_lastAddedNode = node;

			return this;
		}

		private function setStoredCount(node:ITreeNode):void {
			node.multiplier = _countForNextNode;
			_countForNextNode = 1;
		}


		public function an(Type:Class):InstanceModification {
			return a(Type);
		}


		public function get containing():BlockContent {
			++_numberOfOpenSubBranches;
			_currentContainer = _lastAddedNode;
			_lastAddedNode = null;
			_property = null;
			_method = null;
			_isAddingCtorParams = false;
			return this;
		}



		public function times(count:int):Instantiation {
			if(count < 0) {
				throw new ArgumentError("'times' cannot be used with negative numbers (argument was " + count + ")");
			}

			_countForNextNode = count;
			return this;
		}


		public function get end():BlockContent$Finish {
			--_numberOfOpenSubBranches;
			_currentContainer = _currentContainer.parent;
			_lastAddedNode = null;
			return this;
		}

		public function get constructedWith():DataArgument$BlockContent$InstanceModification {
			_isAddingCtorParams = true;
			_method = null;
			_property = null;
			return this;
		}



		public function addConstructorArgument(value:IValue):void {
			_lastAddedNode.addConstructorArg(value);
		}


		public function theInstance(object:DisplayObject):BlockContent$Property {

			var node:InstanceTreeNode = new InstanceTreeNode(object);

			_currentContainer.addChild(node);
			_lastAddedNode = node;

			return this;
		}



		public function forEveryItemIn(collection:*):BlockContent$CollectionProperty__DataDef$BlockStart {
			_lastAddedNode.buildingData = collection;
			return new DataDefinitionBranch(this);
		}




		public function whichWillBeStoredIn(instances:Array):BlockContent$InstanceModification {
			_lastAddedNode.storage = instances;

			return this;
		}




		public function withTheProperty(instancePropertyName:String):_setToThe__SingleValue {
			_property = instancePropertyName;
			_method = null;
			return new SingleValueBranch(this);
		}


		public function theValue(value:*):DataArgument$BlockContent$InstanceModification {
			var wrappedValue:IValue = new StaticValue(value);
			addData(wrappedValue);
			return this;
		}



		//TODO (arneschroppe 04/09/2012) use a better name than "addData". It should convey that this is a general method used to add items or values to properties, methods, constructors, etc
		internal function addData(value:IValue):void {
			if(_isAddingCtorParams) {
				addConstructorArgument(value);
			}
			if(_property) {
				setValueForCurrentProperty(value);
			}
			else if(_method) {
				addArgumentForCurrentMethodCall(value);
			}
		}

		public function setValueForCurrentProperty(value:IValue):void {
			_lastAddedNode.setProperty(_property, value);
			_property = null;
		}


		private function addArgumentForCurrentMethodCall(value:IValue):void {
			_lastAddedNode.addArgumentToMethodCall(_method, value);
		}


		public function withTheName(name:String):BlockContent$InstanceModification {
			_lastAddedNode.setProperty("name", new StaticValue(name));
			return this;
		}



		public function withTheInitializationFunction(initFunction:Function):InstanceModification {
			_lastAddedNode.addInitFunction(initFunction);
			return this;
		}



		public function finish():void {
			checkUnbalancedSubTrees();
			buildStructure();
			endInvocation();
		}



		private function checkUnbalancedSubTrees():void {
			if(_numberOfOpenSubBranches != 0) {
				throw new Error("The number of 'containing' and 'end' does not match");
			}
		}

		private function buildStructure():void {
			_rootTreeNode.build();
		}

		private function endInvocation():void {
			_isStarted = false;
		}


		public function withTheMethod(methodName:String):_calledWith {
			_method = methodName;
			_property = null;
			_isAddingCtorParams = false;
			return this;
		}

		public function get calledWith():DataArgument {
			return this;
		}

		public function get calledWithNoParams():BlockContent$InstanceModification {
			_lastAddedNode.addMethodCallWithNoParams(_method);
			_method = null;
			_isAddingCtorParams = false;
			return this;
		}
	}
}
