package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	public class InstanceTreeNode implements ITreeNode {

		private var _container:DisplayObjectContainer;
		private var _instance:DisplayObject;
		private var _parent:ITreeNode;
		private var _initFunction:Function;

		private var _children:Vector.<ITreeNode> = new <ITreeNode>[];
		private var _storage:Array;
		private var _properties:Dictionary = new Dictionary();

		public function InstanceTreeNode(instance:DisplayObject) {
			_instance = instance;
		}

		public function build():void {
			addInstance();
			storeInStorage();
			applyProperties();
			executeInitFunction();
			buildChildren();
		}

		private function applyProperties():void {
			for(var key:String in _properties) {
				var value:* = _properties[key];
				_instance[key] = value;
			}
		}



		private function addInstance():void {
			if(!_container) {
				return;
			}
			_container.addChild(_instance);
		}

		private function storeInStorage():void {
			if(!_storage) {
				return;
			}

			_storage.push(_instance);
		}

		private function executeInitFunction():void {
			if(_initFunction == null) {
				return;
			}
			_initFunction.call(null, _instance);
		}

		private function buildChildren():void {
			for each(var child:ITreeNode in _children) {
				child.container = DisplayObjectContainer(_instance);
				child.build();
			}
		}


		public function set constructorArgs(value:Array):void {
			throw new Error("Invalid operation");
		}

		public function setProperty(key:String, value:*):void {
			_properties[key] = value;
		}

		public function set initFunction(value:Function):void {
			_initFunction = value;
		}

		public function addChild(child:ITreeNode):void {
			_children.push(child);
			child.parent = this;
		}

		public function set container(value:DisplayObjectContainer):void {
			_container = value;
		}

		public function get parent():ITreeNode {
			return _parent;
		}

		public function set parent(value:ITreeNode):void {
			_parent = value;
		}

		public function set storage(value:Array):void {
			_storage = value;
		}

		public function addInitFunction(value:Function):void {
		}

		public function setConstructorArg(position:int, value:*):void {
		}

		public function set multiplier(multiplier:int):void {
		}
	}
}
