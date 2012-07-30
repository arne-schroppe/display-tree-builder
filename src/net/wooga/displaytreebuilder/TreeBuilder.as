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


		private var _rootTreeNode:RootTreeNode = new RootTreeNode();
		private var _currentNode:ITreeNode;


		private var _isCheckingUnfinishedStatements:Boolean = true;



		public function set isCheckingUnfinishedStatements(value:Boolean):void {
			_isCheckingUnfinishedStatements = value;
		}

		public function get isCheckingUnfinishedStatements():Boolean {
			return _isCheckingUnfinishedStatements;
		}

		public function uses(object:DisplayObject):BlockStart {
			_currentNode = _rootTreeNode;
			_rootTreeNode.root = object;

			return this;
		}



		public function a(Type:Class):InstanceModification {
			var node:SingleTreeNode = new SingleTreeNode();
			node.type = Type;

			if(_currentNode is MultipleTreeNode) {
				MultipleTreeNode(_currentNode).multipliedNode = node;
			}
			else {
				_currentNode.addChild(node);
				_currentNode = node;
			}

			return this;
		}


		public function an(Type:Class):InstanceModification {
			return a(Type);
		}


		public function get containing():BlockContent {

			return this;
		}



		public function times(count:int):Instantiation {


			return this;
		}


		public function get end():BlockContent$Finish {



			return this;
		}

		public function withTheConstructorArguments(...args):BlockContent$InstanceModification {
			return this;
		}

		public function theInstance(object:DisplayObject):BlockContent$Property {


			return this;
		}






		public function forEveryItemIn(collection:*):BlockContent$CollectionProperty__DataDef$BlockStart {

			return new DataDefinitionBranch(this);
		}



		public function withTheProperty(instancePropertyName:String):_setToThe {

			return this;
		}




		public function whichWillBeStoredIn(instances:Array):BlockContent$InstanceModification {


			return this;
		}


		public function finish():void {
			_rootTreeNode.buildSelfAndChildren();
		}


		public function get setToThe():ItemToUse {
			return this;
		}


		public function value(value:*):BlockContent$InstanceModification {
			return this;
		}


		public function withTheName(name:String):BlockContent$InstanceModification {

			return this;
		}



		public function withTheInitializationFunction(initFunction:Function):InstanceModification {
			return this;
		}
	}
}
