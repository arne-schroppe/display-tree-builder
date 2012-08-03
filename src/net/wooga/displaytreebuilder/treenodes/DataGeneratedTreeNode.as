package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObjectContainer;

	public class DataGeneratedTreeNode implements ITreeNode {


		private var _data:*;
		private var _multipliedTreeNode:ITreeNode;


		public function DataGeneratedTreeNode(data:*) {
			_data = data;
		}

		public function get multipliedTreeNode():ITreeNode {
			return _multipliedTreeNode;
		}


		public function buildSelfAndChildren():void {

			//TODO (arneschroppe 30/07/2012) set property or ctor arg, then build

			_multipliedTreeNode.buildSelfAndChildren();
		}


		public function set constructorArgs(value:Array):void {
			_multipliedTreeNode.constructorArgs = value;
		}

		public function setProperty(key:String, value:*):void {
			_multipliedTreeNode.setProperty(key, value);
		}

		public function set initFunction(value:Function):void {
			_multipliedTreeNode.initFunction = value;
		}

		public function addChild(child:ITreeNode):void {
			_multipliedTreeNode.addChild(child);
		}



		public function get parent():ITreeNode {
			return _multipliedTreeNode.parent;
		}

		public function set parent(value:ITreeNode):void {
			_multipliedTreeNode.parent = value;

		}

		public function set container(container:DisplayObjectContainer):void {
			_multipliedTreeNode.container = container;
		}
	}
}
