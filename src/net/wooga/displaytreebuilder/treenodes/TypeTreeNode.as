package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	import net.wooga.displaytreebuilder.tools.InstantiationTool;
	import net.wooga.displaytreebuilder.tools.UnifiedCollection;
	import net.wooga.displaytreebuilder.values.IValue;

	public class TypeTreeNode implements ITreeNode {

		private var _type:Class;

		private var _constructorArgs:Array = []; //Array of IValue (we're not using Vector because we want a sparse array)
		private var _properties:Dictionary = new Dictionary();
		private var _methods:Dictionary = new Dictionary();

		private var _initFunctions:Vector.<Function> = new <Function>[];

		private var _children:Vector.<ITreeNode> = new <ITreeNode>[];
		private var _container:DisplayObjectContainer;

		private var _parent:ITreeNode;
		private var _storage:Array;
		private var _multiplier:int;
		private var _buildingData:UnifiedCollection;


		public function build():void {
			for(var i:int = 0; i < _multiplier; ++i) {
				createFromData();
			}
		}

		private function createFromData():void {
			if(!_buildingData || !_buildingData.hasContent) {
				buildInstance(null);
				return;
			}

			for each(var item:* in _buildingData.collection) {
				buildInstance(item);
			}
		}

		private function buildInstance(item:*):void {
			var instance:DisplayObject = createInstance(item);
			applyProperties(instance, item);
			callMethods(instance, item);
			addToContainer(instance);
			executeInitFunctions(instance);
			buildChildren(instance);
		}



		private function createInstance(dataItem:*):DisplayObject {
			var constructorArgs:Array = buildConstructorArgsArray(dataItem);
			var instance:DisplayObject = DisplayObject(InstantiationTool.instantiate(_type, constructorArgs));
			if(_storage) {
				_storage.push(instance);
			}

			return instance;
		}

		private function buildConstructorArgsArray(dataItem:*):Array {

			var args:Array = [];

			for each(var value:IValue in _constructorArgs) {
				args.push(value.getValue(dataItem));
			}

			return args;
		}


		private function applyProperties(instance:DisplayObject, item:*):void {
			for(var key:String in _properties) {
				var value:IValue = _properties[key];
				instance[key] = value.getValue(item);
			}
		}


		private function callMethods(instance:DisplayObject, item:*):void {
			for(var methodName:String in _methods) {
				var wrappedParams:Vector.<IValue> = _methods[methodName];
				var params:Array = extractValues(wrappedParams, item);

				var method:Function = instance[methodName] as Function;
				method.apply(instance, params);
			}
		}

		private function extractValues(wrappedParams:Vector.<IValue>, item:*):Array {
			var params:Array = [];

			for each(var wrappedValue:IValue in wrappedParams) {
				params.push(wrappedValue.getValue(item));
			}

			return params;
		}


		private function addToContainer(instance:DisplayObject):void {
			_container.addChild(instance)
		}


		private function executeInitFunctions(instance:DisplayObject):void {
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

			_constructorArgs.push(value);
		}

		public function setProperty(key:String, value:IValue):void {
			_properties[key] = value;
		}


		public function set multiplier(multiplier:int):void {
			_multiplier = multiplier;
		}

		public function set buildingData(value:*):void {
			_buildingData = new UnifiedCollection(value);
		}

		public function addMethodCallWithNoParams(methodName:String):void {
			_methods[methodName] = new Vector.<IValue>();
		}


		public function addArgumentToMethodCall(methodName:String, value:IValue):void {
			if(!(methodName in _methods)) {
				_methods[methodName] = new Vector.<IValue>();
			}

			Vector.<IValue>(_methods[methodName]).push(value);
		}
	}
}
