package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObjectContainer;

	public interface ITreeNode {

		function build():void;

		function addInitFunction(value:Function):void;

		function addChild(child:ITreeNode):void;
		function get parent():ITreeNode;
		function set parent(value:ITreeNode):void;


		function set container(container:DisplayObjectContainer):void;
		function set storage(value:Array):void;


		function setConstructorArg(position:int,  value:*):void;
		function setProperty(key:String, value:*):void;

		function set multiplier(multiplier:int):void;
		function set buildingData(data:*):void;
	}
}
