package net.wooga.fixtures.reflection {
	public class TestClassA implements InterfaceA {

		public function someMethod():InterfaceB {
			return new TestClassB;
		}

		public function get someProperty():InterfaceB {
			return new TestClassB();
		}

		public function set someWriteOnlyProperty(value:InterfaceB):void {
		}

		public function methodInImplementedInterface():InterfaceB {
			return new TestClassB();
		}
	}
}
