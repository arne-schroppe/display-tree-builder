package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObjectContainer;

	public class MultipleTreeNode implements ITreeNode {


		private var _count:int;
		private var _multipliedNode:ITreeNode;

		public function MultipleTreeNode(count:int) {
			_count = count;
		}

		public function set multipliedNode(value:ITreeNode):void {
			_multipliedNode = value;
		}

		public function buildSelfAndChildren():void {
			for(var i:int = 0; i < _count; ++i) {
				_multipliedNode.buildSelfAndChildren();
			}
		}

		public function set constructorArgs(value:Array):void {
			_multipliedNode.constructorArgs = value;
		}

		public function setProperty(key:String, value:*):void {
			_multipliedNode.setProperty(key, value);
		}

		public function set initFunction(value:Function):void {
			_multipliedNode.initFunction = value;
		}

		public function addChild(child:ITreeNode):void {
			_multipliedNode.addChild(child);
		}


		public function get parent():ITreeNode {
			return _multipliedNode.parent;
		}

		public function set parent(value:ITreeNode):void {
			_multipliedNode.parent = value;
		}

		public function set container(container:DisplayObjectContainer):void {
			_multipliedNode.container = container;
		}

		public function set storage(value:Array):void {
			_multipliedNode.storage = value;
		}
	}
}
