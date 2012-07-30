package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class RootTreeNode implements ITreeNode {

		private var _children:Vector.<SingleTreeNode> = new <SingleTreeNode>[];


		public function RootTreeNode() {
		}


		private var _root:DisplayObject;


		public function buildSelfAndChildren():void {

			for each(var child:SingleTreeNode in _children) {
				child.container = DisplayObjectContainer(_root);
				child.buildSelfAndChildren();
			}
		}

		public function set type(value:Class):void {
		}

		public function set constructorArgs(value:Array):void {
		}

		public function setProperty(key:String, value:*):void {
		}

		public function set initFunction(value:Function):void {
		}

		public function addChild(child:ITreeNode):void {
		}

		public function set container(value:DisplayObjectContainer):void {
		}

		public function set root(value:DisplayObject):void {
			_root = value;
		}

		public function get parent():ITreeNode {
			return null;
		}
	}
}
