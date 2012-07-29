package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class InstanceTreeNode implements ITreeNode {

		private var _container:DisplayObjectContainer;
		private var _instance:DisplayObject;


		public function InstanceTreeNode(instance:DisplayObject) {
			_instance = instance;
		}

		public function buildSelfAndChildren():void {
			_container.addChild(_instance);
			//TODO (arneschroppe 30/07/2012) exec init function
			//TODO (arneschroppe 30/07/2012) createChildren
		}

		public function set type(value:Class):void {
			throw new Error("Invalid operation");
		}

		public function set constructorArgs(value:Array):void {
			throw new Error("Invalid operation");
		}

		public function setProperty(key:String, value:*):void {
			//Is it invalid? throw new Error("Invalid operation");
		}

		public function set initFunction(value:Function):void {

		}

		public function addChild(child:SingleTreeNode):void {
		}

		public function set container(value:DisplayObjectContainer):void {
			_container = value;
		}
	}
}
