package net.wooga.displaytreebuilder {
	import flash.display.DisplayObject;

	import net.wooga.displaytreebuilder.grammar.BlockContent;
	import net.wooga.displaytreebuilder.grammar.BlockContent$CollectionProperty$BlockStart;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Finish;
	import net.wooga.displaytreebuilder.grammar.BlockContent$InstanceModification;
	import net.wooga.displaytreebuilder.grammar.BlockContent$Property;
	import net.wooga.displaytreebuilder.grammar.BlockStart;
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
	import net.wooga.displaytreebuilder.treenodes.MultipleTreeNode;
	import net.wooga.displaytreebuilder.treenodes.RootTreeNode;
	import net.wooga.displaytreebuilder.treenodes.SingleTreeNode;

	internal class TreeBuilder implements BlockContent$Property, _finish, ItemToUse, _setToThe, BlockContent$CollectionProperty$BlockStart, BlockContent$Finish, BlockContent$InstanceModification, BlockStart, DataDefinition, TreeStart, Instantiation, NameProperty, Storage {


		private var _rootTreeNode:RootTreeNode;
		private var _currentContainer:ITreeNode;
		private var _lastAddedNode:ITreeNode;

		private var _parkedMultipleTreeNode:MultipleTreeNode;


		private var _isCheckingUnfinishedStatements:Boolean = true;



		public function set isCheckingUnfinishedStatements(value:Boolean):void {
			_isCheckingUnfinishedStatements = value;
		}

		public function get isCheckingUnfinishedStatements():Boolean {
			return _isCheckingUnfinishedStatements;
		}

		public function uses(object:DisplayObject):BlockStart {
			_rootTreeNode = new RootTreeNode();
			_rootTreeNode.root = object;
			_lastAddedNode = _rootTreeNode;

			return this;
		}



		public function a(Type:Class):InstanceModification {
			var node:SingleTreeNode = new SingleTreeNode();
			node.type = Type;

			var addedNode:ITreeNode;
			if(_parkedMultipleTreeNode) {
				_parkedMultipleTreeNode.multipliedNode = node;
				addedNode = _parkedMultipleTreeNode;
				_parkedMultipleTreeNode = null;
			}
			else {
				addedNode = node;
			}

			_currentContainer.addChild(addedNode);

			_lastAddedNode = addedNode;

			return this;
		}


		public function an(Type:Class):InstanceModification {
			return a(Type);
		}


		public function get containing():BlockContent {
			_currentContainer = _lastAddedNode;
			_lastAddedNode = null;
			return this;
		}



		public function times(count:int):Instantiation {
			_parkedMultipleTreeNode = new MultipleTreeNode(count);

			return this;
		}


		public function get end():BlockContent$Finish {
			_currentContainer = _currentContainer.parent;
			_lastAddedNode = null;
			return this;
		}

		public function withTheConstructorArguments(...args):BlockContent$InstanceModification {
			_lastAddedNode.constructorArgs = args;
			return this;
		}

		public function theInstance(object:DisplayObject):BlockContent$Property {

			//TODO (arneschroppe 03/08/2012) implement me
			return this;
		}



		public function forEveryItemIn(collection:*):BlockContent$CollectionProperty__DataDef$BlockStart {

			return new DataDefinitionBranch(this);
		}







		public function whichWillBeStoredIn(instances:Array):BlockContent$InstanceModification {


			return this;
		}


		public function finish():void {
			_rootTreeNode.buildSelfAndChildren();
		}


		private var _property:String;
		public function withTheProperty(instancePropertyName:String):_setToThe {

			_property = instancePropertyName;
			return this;
		}


		public function get setToThe():ItemToUse {
			return this;
		}


		public function value(value:*):BlockContent$InstanceModification {
			_lastAddedNode.setProperty(_property, value);
			_property = null;
			return this;
		}


		public function withTheName(name:String):BlockContent$InstanceModification {
			_lastAddedNode.setProperty("name", name);
			return this;
		}



		public function withTheInitializationFunction(initFunction:Function):InstanceModification {
			_lastAddedNode.initFunction = initFunction;
			return this;
		}
	}
}
