package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.wooga.displaytreebuilder.grammar.BlockContent;
	import net.wooga.displaytreebuilder.grammar.BlockContent$CollectionProperty$BlockStart;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Finish;
	import net.wooga.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Property;
	import net.wooga.displaytreebuilder.grammar.BlockStart;
	import net.wooga.displaytreebuilder.grammar.CtorArgument$BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.DataDefinition;
	import net.wooga.displaytreebuilder.grammar.InstanceModification;
	import net.wooga.displaytreebuilder.grammar.Instantiation;
	import net.wooga.displaytreebuilder.grammar.ItemToUse;
	import net.wooga.displaytreebuilder.grammar.NameProperty;
	import net.wooga.displaytreebuilder.grammar.Storage;
	import net.wooga.displaytreebuilder.grammar.TreeStart;
	import net.wooga.displaytreebuilder.grammar._finish;
	import net.wooga.displaytreebuilder.grammar._setToThe;
	import net.wooga.displaytreebuilder.grammar.datadefinition.BlockContent$CollectionProperty__DataDef$BlockStart;
	import net.wooga.displaytreebuilder.treenodes.ITreeNode;
	import net.wooga.displaytreebuilder.treenodes.InstanceTreeNode;
	import net.wooga.displaytreebuilder.treenodes.TypeTreeNode;
	import net.wooga.displaytreebuilder.values.IValue;
	import net.wooga.displaytreebuilder.values.StaticValue;

	internal class TreeBuilder implements CtorArgument$BlockContent$InstanceModification, BlockContent$Property, _finish, ItemToUse, _setToThe, BlockContent$CollectionProperty$BlockStart, BlockContent$Finish, BlockContent$InstanceModification, BlockStart, DataDefinition, TreeStart, Instantiation, NameProperty, Storage {


		private var _rootTreeNode:InstanceTreeNode;
		private var _currentContainer:ITreeNode;
		private var _lastAddedNode:ITreeNode;

		private var _countForNextNode:int;
		private var _property:String;

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

		public function get constructedWith():CtorArgument$BlockContent$InstanceModification {
			return this;
		}



		public function theValue(ctorArgument:*):CtorArgument$BlockContent$InstanceModification {
			addConstructorArgument(new StaticValue(ctorArgument));
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




		public function withTheProperty(instancePropertyName:String):_setToThe {
			_property = instancePropertyName;
			return this;
		}


		public function get setToThe():ItemToUse {
			return this;
		}


		public function value(value:*):BlockContent$InstanceModification {
			setValueForCurrentProperty(new StaticValue(value));
			return this;
		}


		public function setValueForCurrentProperty(value:IValue):void {
			_lastAddedNode.setProperty(_property, value);
			_property = null;
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


	}
}
