package net.wooga.displaytreebuilder.builder {
	import flash.display.Sprite;

	import net.wooga.displaytreebuilder.DisplayTree;
	import net.wooga.fixtures.InitTestSprite;
	import net.wooga.fixtures.TestSprite1;
	import net.wooga.fixtures.TestSprite2;
	import net.wooga.fixtures.TestSprite3;
	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;

	public class TreeBuilderBugsTest {
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
		public function should_correctly_add_several_types_from_data():void {


			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(["1", "2", "3"])
						.withTheProperty("name").setTo.theItem

					.a(TestSprite2).forEveryItemIn(["4", "5"])
						.withTheProperty("name").setTo.theItem

					.end.finish()

			assertThat(_contextView.numChildren, equalTo(5));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));
			assertThat(_contextView.getChildAt(3), isA(TestSprite2));
			assertThat(_contextView.getChildAt(4), isA(TestSprite2));

			assertThat(_contextView.getChildAt(0).name, equalTo("1"));
			assertThat(_contextView.getChildAt(1).name, equalTo("2"));
			assertThat(_contextView.getChildAt(2).name, equalTo("3"));
			assertThat(_contextView.getChildAt(3).name, equalTo("4"));
			assertThat(_contextView.getChildAt(4).name, equalTo("5"));


		}


		[Test]
		public function should_add_children_in_the_order_they_are_added_to_the_tree():void {
			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1)
					.a(TestSprite2)
					.a(TestSprite3)
					.a(InitTestSprite)
				.end.finish();

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite2));
			assertThat(_contextView.getChildAt(2), isA(TestSprite3));
			assertThat(_contextView.getChildAt(3), isA(InitTestSprite));
		}
	}
}
