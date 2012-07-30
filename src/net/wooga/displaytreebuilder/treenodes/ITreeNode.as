package net.wooga.displaytreebuilder.treenodes {
	import flash.display.DisplayObjectContainer;

	public interface ITreeNode {
		function buildSelfAndChildren():void;

		function set constructorArgs(value:Array):void;

		function setProperty(key:String, value:*):void;

		function set initFunction(value:Function):void;

		function addChild(child:ITreeNode):void;
		function get parent():ITreeNode;

		function set container(value:DisplayObjectContainer):void;
	}
}
