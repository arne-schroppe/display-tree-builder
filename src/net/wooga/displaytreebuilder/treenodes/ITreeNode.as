package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObjectContainer;

	import net.wooga.displaytreebuilder.values.IValue;

	public interface ITreeNode {

		function build():void;

		function addInitFunction(value:Function):void;

		function addChild(child:ITreeNode):void;
		function get parent():ITreeNode;
		function set parent(value:ITreeNode):void;


		function set container(container:DisplayObjectContainer):void;
		function set storage(value:Array):void;


		function addConstructorArg(value:IValue):void;
		function setProperty(key:String, value:IValue):void;

		function set multiplier(multiplier:int):void;
		function set buildingData(data:*):void;
	}
}
