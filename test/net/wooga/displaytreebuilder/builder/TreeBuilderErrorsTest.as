package net.wooga.displaytreebuilder.builder {
	import flash.display.Sprite;

	import net.wooga.displaytreebuilder.DisplayTree;
	import net.wooga.fixtures.TestSprite1;
	import net.wooga.fixtures.TestSprite2;
	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.core.throws;

	public class TreeBuilderErrorsTest {

		private var _contextView:Sprite;

		private var _displayTreeBuilder:DisplayTree;


		[Before]
		public function setUp():void {
			_contextView = new Sprite();
			FlexUnitUtils.stage.addChild(_contextView);

			_displayTreeBuilder = new DisplayTree();
		}


		[After]
		public function tearDown():void {
			FlexUnitUtils.stage.removeChild(_contextView);
			_contextView = null;

		}


		[Test]
		public function should_throw_exception_for_unfinished_invocations():void {

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1)
				.end //not finished


			assertThat(
					function ():void {
						_displayTreeBuilder.uses(_contextView)
					}, throws(isA(Error))
			);
		}


		[Test]
		public function should_throw_error_for_unaligned_containing_and_end():void {

			assertThat(function():void {
				_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).containing
						.a(TestSprite2)
					//missing 'end'
				.end.finish()
			}, throws(isA(Error)))
		}


		[Test]
		public function should_throw_an_exception_if_addInstance_is_used_in_subbranch_of_loop():void {

			assertThat(function():void {
				_displayTreeBuilder.uses(_contextView).containing
					.times(2).a(TestSprite1).containing
						.theInstance(new TestSprite2())
					.end
				.end.finish()
			}, throws(isA(Error)))

		}



		[Test]
		public function should_not_throw_an_exception_if_addInstance_is_used_with_single_element_loop():void {

			assertThat(function():void {
				_displayTreeBuilder.uses(_contextView).containing
					.times(1).a(TestSprite1).containing
						.theInstance(new TestSprite2())
					.end
				.end.finish()
			}, not(throws(isA(Error))))

		}


		[Test]
		public function should_throw_an_exception_if_times_is_used_with_negative_number():void {

			assertThat(function():void {
				_displayTreeBuilder.uses(_contextView).containing
						.times(-1).a(TestSprite1).containing
							.a(TestSprite2)
						.end
					.end.finish()
			}, throws(isA(Error)))

		}


		[Test]
		public function should_not_throw_an_exception_if_times_is_used_with_zero():void {

			assertThat(function():void {
				_displayTreeBuilder.uses(_contextView).containing
						.times(0).a(TestSprite1).containing
							.a(TestSprite2)
						.end
					.end.finish()
			}, not(throws(isA(Error))))

		}
	}
}




