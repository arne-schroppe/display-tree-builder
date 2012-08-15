package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import net.wooga.displaytreebuilder.values.IValue;

	public class InstanceTreeNode implements ITreeNode {

		private var _wasAlreadyAdded:Boolean = false;
		private var _container:DisplayObjectContainer;
		private var _instance:DisplayObject;
		private var _parent:ITreeNode;
		private var _initFunctions:Array = [];

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
			executeInitFunctions();
			buildChildren();
		}

		private function applyProperties():void {
			for(var key:String in _properties) {
				var value:IValue = _properties[key];
				_instance[key] = value.getValue(null);
			}
		}



		private function addInstance():void {
			if(!_container) {
				return;
			}

			if(_wasAlreadyAdded) {
				throw new Error("Cannot add an instance several times");
			}

			_container.addChild(_instance);
			_wasAlreadyAdded = true;
		}

		private function storeInStorage():void {
			if(!_storage) {
				return;
			}

			_storage.push(_instance);
		}

		private function executeInitFunctions():void {
			for each(var func:Function in _initFunctions) {
				func.call(null, _instance);
			}
		}

		private function buildChildren():void {
			for each(var child:ITreeNode in _children) {
				child.container = DisplayObjectContainer(_instance);
				child.build();
			}
		}

		public function setProperty(key:String, value:IValue):void {
			_properties[key] = value;
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
			_initFunctions.push(value);
		}

		public function addConstructorArg(value:IValue):void {
			throw new Error("Invalid Operation"); //TODO (arneschroppe 05/08/2012) test this
		}

		public function set multiplier(multiplier:int):void {
			throw new Error("Invalid Operation"); //TODO (arneschroppe 05/08/2012) test this
		}

		public function set buildingData(data:*):void {
			throw new Error("Invalid Operation"); //TODO (arneschroppe 05/08/2012) test this
		}
	}
}
