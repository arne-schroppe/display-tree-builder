package net.wooga.fixtures.reflection {
	public interface InterfaceA extends SuperInterfaceA {

		function someMethod():InterfaceB;

		function get someProperty():InterfaceB;

		function set someWriteOnlyProperty(value:InterfaceB):void;
	}
}
