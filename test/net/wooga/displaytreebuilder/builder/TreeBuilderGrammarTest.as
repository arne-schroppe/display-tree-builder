package net.wooga.displaytreebuilder.builder {
	import flash.display.Sprite;

	import net.wooga.displaytreebuilder.DisplayTree;
	import net.wooga.fixtures.TestSprite1;
	import net.wooga.testingtools.Reflection;
	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;

	public class TreeBuilderGrammarTest {


		//TODO (arneschroppe 06/09/2012) we could actually test the grammar.
		//Take the class of the return value and check if it contains a certain method

		private var _contextView:Sprite;
		private var _displayTreeBuilder:DisplayTree;
		private var _reflection:Reflection;


		[Before]
		public function setUp():void {
			_contextView = new Sprite();
			FlexUnitUtils.stage.addChild(_contextView);

			_displayTreeBuilder = new DisplayTree();
			_reflection = new Reflection();
		}

		[After]
		public function tearDown():void {
			FlexUnitUtils.stage.removeChild(_contextView);
			_contextView = null;

		}


		[Test]
		public function should_not_have_more_than_one_property_value():void {

			assertThat(_reflection.isFollowedBy(
					_displayTreeBuilder.uses(_contextView).containing
						.a(TestSprite1)
					.withTheProperty("name").setTo,
					"theValue",
					"theValue"),

				equalTo(false)
			);
		}

		[Test]
		public function should_allow_for_several_method_values():void {
			assertThat(_reflection.isFollowedBy(
					_displayTreeBuilder.uses(_contextView).containing
							.a(TestSprite1)
							.withTheMethod("name").calledWith,
					"theValue",
					"theValue"),

					equalTo(true)
			);
		}

		[Test]
		public function item_should_not_be_available():void {
			assertThat(_reflection.isFollowedBy(
					_displayTreeBuilder.uses(_contextView).containing
							.a(TestSprite1)
								.withTheMethod("name").calledWith,
					"theValue",
					"theItem"),

					equalTo(false)
			);
		}




	}
}
