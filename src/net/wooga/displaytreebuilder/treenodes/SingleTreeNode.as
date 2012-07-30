package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import net.wooga.displaytreebuilder.tools.InstantiationTool;

	public class SingleTreeNode implements ITreeNode {

		private var _type:Class;

		private var _constructorArgs:Array = [];
		private var _properties:Dictionary = new Dictionary();

		private var _initFunction:Function;

		private var _children:Vector.<SingleTreeNode> = new <SingleTreeNode>[];


		private var _container:DisplayObjectContainer;

		//Only available after a call to build
		private var _instance:DisplayObject;


		public function buildSelfAndChildren():void {
			build();
			buildChildren();
		}

		private function build():void {
			createInstance();
			applyProperties();
			addToContainer();
			executeInitFunction();
		}


		private function createInstance():void {
			_instance = DisplayObject(InstantiationTool.instantiate(_type, _constructorArgs));
		}


		private function applyProperties():void {
			for(var key:String in _properties) {
				var value:* = _properties[key];
				_instance[key] = value;
			}
		}

		private function addToContainer():void {
			_container.addChild(_instance)
		}

		private function executeInitFunction():void {
			_initFunction.apply(null, _instance);
		}


		private function buildChildren():void {
			for each(var child:SingleTreeNode in _children) {
				child.container = DisplayObjectContainer(_instance);
				child.buildSelfAndChildren();
			}
		}

		public function set type(value:Class):void {
			_type = value;
		}

		public function set constructorArgs(value:Array):void {
			_constructorArgs = value;
		}


		public function setProperty(key:String, value:*):void {
			_properties[key] = value;
		}

		public function set initFunction(value:Function):void {
			_initFunction = value;
		}


		public function addChild(child:ITreeNode):void {
			_children.push(child);
		}

		public function set container(value:DisplayObjectContainer):void {
			_container = value;
		}

		public function get parent():ITreeNode {
			return null;
		}
	}
}
