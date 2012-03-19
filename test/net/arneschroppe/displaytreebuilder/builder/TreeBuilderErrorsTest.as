package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.Sprite;

	import net.arneschroppe.displaytreebuilder.DisplayTree;

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

			_displayTreeBuilder.hasA(_contextView).containing
					.a(TestSprite1)
				.end //not finished


			assertThat(
					function ():void {
						_displayTreeBuilder.hasA(_contextView)
					}, throws(isA(Error))
			);
		}


		[Test]
		public function check_for_unfinished_invocation_should_be_optional():void {

			_displayTreeBuilder.hasA(_contextView).containing
				.a(TestSprite1)
			.end //not finished


			assertThat(
					function ():void {
						_displayTreeBuilder.isCheckingUnfinishedStatements = false;
						_displayTreeBuilder.hasA(_contextView)
					}, not(throws(isA(Error)))
			);
		}

		[Test]
		public function should_throw_error_for_unaligned_begin_and_end():void {

			assertThat(function():void {
				_displayTreeBuilder.hasA(_contextView).containing
					.a(TestSprite1).containing
						.a(TestSprite2)
					//missing 'end'
				.end.finish()
			}, throws(isA(Error)))
		}


		[Test]
		public function should_throw_an_exception_if_addInstance_is_used_in_subbranch_of_loop():void {

			assertThat(function():void {
				_displayTreeBuilder.hasA(_contextView).containing
					.times(2).a(TestSprite1).containing
						.theInstance(new TestSprite2())
					.end
				.end.finish()
			}, throws(isA(Error)))

		}



		[Test]
		public function should_not_throw_an_exception_if_addInstance_is_used_with_single_element_loop():void {

			assertThat(function():void {
				_displayTreeBuilder.hasA(_contextView).containing
					.times(1).a(TestSprite1).containing
						.theInstance(new TestSprite2())
					.end
				.end.finish()
			}, not(throws(isA(Error))))

		}
	}
}


import flash.display.Sprite;

class TestSprite1 extends Sprite {


}

class TestSprite2 extends Sprite {

}

class TestSprite3 extends Sprite {

}

