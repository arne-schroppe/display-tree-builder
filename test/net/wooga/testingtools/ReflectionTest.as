package net.wooga.testingtools {
	import net.wooga.fixtures.reflection.InterfaceA;
	import net.wooga.fixtures.reflection.InterfaceB;
	import net.wooga.fixtures.reflection.TestClassA;
	import net.wooga.fixtures.reflection.TestClassB;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;

	public class ReflectionTest {

		private var _reflection:Reflection;

		private var _dummy1:InterfaceA;
		private var _dummy2:InterfaceB;
		private var _dummy3:TestClassB;

		[Before]
		public function setUp():void {
			_reflection = new Reflection();
		}

		[Test]
		public function should_correctly_show_that_a_method_is_followed_by_another_method():void {

			var testObject:TestClassA = new TestClassA();

			assertThat(_reflection.isFollowedBy(testObject, "someMethod", "followingMethod"), equalTo(true));

		}


		[Test]
		public function should_correctly_show_that_a_property_is_followed_by_a_method():void {

			var testObject:TestClassA = new TestClassA();

			assertThat(_reflection.isFollowedBy(testObject, "someProperty", "followingMethod"), equalTo(true));

		}


		[Test]
		public function should_correctly_show_that_a_property_is_followed_by_another_property():void {

			var testObject:TestClassA = new TestClassA();

			assertThat(_reflection.isFollowedBy(testObject, "someProperty", "followingProperty"), equalTo(true));

		}

		[Test]
		public function should_correctly_show_that_a_method_is_followed_by_a_property():void {

			var testObject:TestClassA = new TestClassA();

			assertThat(_reflection.isFollowedBy(testObject, "someMethod", "followingProperty"), equalTo(true));

		}


		[Test]
		public function should_throw_exception_for_unknown_method():void {

			var testObject:TestClassA = new TestClassA();

			assertThat(function():void{
				_reflection.isFollowedBy(testObject, "DOES_NOT_EXIST", "followingProperty")

			}, throws(isA(ArgumentError)));
		}


		[Test]
		public function should_not_indicate_a_connection_with_write_only_properties():void {
			var testObject:TestClassA = new TestClassA();
			assertThat(_reflection.isFollowedBy(testObject, "someWriteOnlyProperty", "invisibleMethod"), equalTo(false));
		}


		[Test]
		public function should_not_indicate_a_connection_to_invisible_methods():void {

			var testObject:TestClassA = new TestClassA();

			assertThat(_reflection.isFollowedBy(testObject, "someMethod", "invisibleMethod"), equalTo(false));

		}

	}
}