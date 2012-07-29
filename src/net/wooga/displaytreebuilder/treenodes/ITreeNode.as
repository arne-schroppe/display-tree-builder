package net.wooga.displaytreebuilder.treenodes {
	import net.wooga.displaytreebuilder.*;
	import flash.display.DisplayObjectContainer;

	public interface ITreeNode {
		function buildSelfAndChildren():void;

		function set type(value:Class):void;

		function set constructorArgs(value:Array):void;

		function setProperty(key:String, value:*):void;

		function set initFunction(value:Function):void;

		function addChild(child:SingleTreeNode):void;

		function set container(value:DisplayObjectContainer):void;
	}
}
