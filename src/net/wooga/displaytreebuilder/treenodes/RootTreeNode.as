package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class RootTreeNode implements ITreeNode {

		private var _children:Vector.<ITreeNode> = new <ITreeNode>[];
		private var _storage:Array;

		public function RootTreeNode() {
		}


		private var _root:DisplayObject;
		private var _parent:ITreeNode;


		public function buildSelfAndChildren():void {

			if(_storage) {
				_storage.push(_root);
			}

			for each(var child:ITreeNode in _children) {
				child.container = DisplayObjectContainer(_root);
				child.buildSelfAndChildren();
			}
		}


		public function set constructorArgs(value:Array):void {
		}

		public function setProperty(key:String, value:*):void {
		}

		public function set initFunction(value:Function):void {
		}

		public function addChild(child:ITreeNode):void {
			_children.push(child);
			child.parent = this;
		}


		public function set root(value:DisplayObject):void {
			_root = value;
		}

		public function get parent():ITreeNode {
			return _parent;
		}

		public function set parent(value:ITreeNode):void {
			_parent = value;
		}

		public function set container(container:DisplayObjectContainer):void {
		}

		public function set storage(value:Array):void {
			_storage = value;
		}
	}
}
