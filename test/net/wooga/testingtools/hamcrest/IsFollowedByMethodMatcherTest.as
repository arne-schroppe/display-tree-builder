package net.wooga.testingtools.hamcrest {
	import net.wooga.fixtures.reflection.TestClassA;

	import org.hamcrest.AssertionError;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.throws;

	public class IsFollowedByMethodMatcherTest {



		[Test]
		public function should_correctly_match_following_method():void {
			assertThat(method(new TestClassA(), "someMethod"), isFollowedBy("followingMethod") )
		}


		[Test]
		public function should_signal_an_error_if_it_does_not_match():void {

			assertThat(function ():void {
				assertThat(method(new TestClassA(), "someMethod"), isFollowedBy("DOES_NOT_EXIST"))
			}, throws(isA(AssertionError)));

		}
	}
}
