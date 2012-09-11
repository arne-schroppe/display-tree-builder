package net.wooga.displaytreebuilder.builder {
	import flash.display.Sprite;

	import net.wooga.displaytreebuilder.DisplayTree;
	import net.wooga.fixtures.TestSprite1;
	import net.wooga.testingtools.hamcrest.isFollowedBy;
	import net.wooga.testingtools.hamcrest.method;
	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.not;

	public class TreeBuilderGrammarTest {


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
		public function should_start_with_block():void {
			assertThat(
					method(
							_displayTreeBuilder,
							"uses"),

					isFollowedBy("containing"));
		}


		[Test]
		public function should_not_have_more_than_one_property_value():void {

			assertThat(
					method(
					_displayTreeBuilder.uses(_contextView).containing
						.a(TestSprite1)
					.withTheProperty("name").setTo,
					"theValue"),

					not(isFollowedBy("theValue")));
		}

		[Test]
		public function should_allow_for_several_method_values():void {
			assertThat(
					method(
					_displayTreeBuilder.uses(_contextView).containing
							.a(TestSprite1)
							.withTheMethod("name").calledWith,
					"theValue"),

					isFollowedBy("theValue")
			);
		}

		[Test]
		public function item_should_not_be_available_if_there_was_no_prior_item_definition():void {
			assertThat(
					method(
					_displayTreeBuilder.uses(_contextView).containing
							.a(TestSprite1)
								.withTheMethod("name").calledWith,
					"theValue"),

					not(isFollowedBy("theItem")));
		}

		[Test]
		public function item_should_be_available_if_there_was_an_item_definition():void {

			assertThat(
				method(_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(["a", "b", "c"]), "constructedWith"),
				allOf(isFollowedBy("theItem"), isFollowedBy("theItemProperty"))
			);

		}



	}
}
