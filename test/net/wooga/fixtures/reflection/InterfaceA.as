package net.wooga.fixtures.reflection {
	public interface InterfaceA {

		function someMethod():InterfaceB;

		function get someProperty():InterfaceB;

		function set someWriteOnlyProperty(value:InterfaceB):void;
	}
}
