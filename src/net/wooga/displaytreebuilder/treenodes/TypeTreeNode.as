package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import net.wooga.displaytreebuilder.tools.InstantiationTool;

	public class TypeTreeNode implements ITreeNode {

		private var _type:Class;

		private var _constructorArgs:Array = [];
		private var _properties:Dictionary = new Dictionary();

		private var _initFunctions:Vector.<Function> = new <Function>[];

		private var _children:Vector.<ITreeNode> = new <ITreeNode>[];
		private var _container:DisplayObjectContainer;

		private var _parent:ITreeNode;
		private var _storage:Array;
		private var _multiplier:int;





		public function build():void {
			for(var i:int = 0; i < _multiplier; ++i) {
				createFromData();
			}
		}

		private function createFromData():void {
			buildInstance();
		}

		private function buildInstance():void {
			var instance:DisplayObject = createInstance();
			applyProperties(instance);
			addToContainer(instance);
			executeInitFunction(instance);
			buildChildren(instance);
		}



		private function createInstance():DisplayObject {
			var instance:DisplayObject = DisplayObject(InstantiationTool.instantiate(_type, _constructorArgs));
			if(_storage) {
				_storage.push(instance);
			}

			return instance;
		}


		private function applyProperties(instance:DisplayObject):void {
			for(var key:String in _properties) {
				var value:* = _properties[key];
				instance[key] = value;
			}
		}

		private function addToContainer(instance:DisplayObject):void {
			_container.addChild(instance)
		}


		private function executeInitFunction(instance:DisplayObject):void {

			for each(var func:Function in _initFunctions) {
				func.call(null, instance);
			}


		}


		private function buildChildren(instance:DisplayObject):void {
			for each(var child:ITreeNode in _children) {
				child.container = DisplayObjectContainer(instance);
				child.build();
			}
		}

		public function set type(value:Class):void {
			_type = value;
		}


		public function setProperty(key:String, value:*):void {
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

		public function setConstructorArg(position:int, value:*):void {
			_constructorArgs[position] = value;
		}

		public function set multiplier(multiplier:int):void {
			_multiplier = multiplier;
		}

		public function set buildingData(value:*):void {
			_buildingData = value;
		}
	}
}
