package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.mockito.integrations.times;

	public class BuilderTest {

		private var _contextView:Sprite;

		private var _displayTreeBuilder:Builder;


		[Before]
		public function setUp():void {
			_contextView = new Sprite();
			FlexUnitUtils.stage.addChild(_contextView);

			_displayTreeBuilder = new Builder();
		}


		[After]
		public function tearDown():void {
			FlexUnitUtils.stage.removeChild(_contextView);
			_contextView = null;

		}


		[Test]
		public function should_add_a_simple_object():void {

			_displayTreeBuilder.startWith(_contextView).begin
				.add(TestSprite)
			.end.stop();

			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), isA(TestSprite));
		}


		[Test]
		public function should_add_a_name_to_an_object():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.add(TestSprite).withName("testname")
			.end.stop();

			assertThat(_contextView.getChildAt(0).name, equalTo("testname"));
		}

		[Test]
		public function should_allow_sub_objects():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.add(Sprite).begin
					.add(TestSprite)
				.end
			.end.stop();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).getChildAt(0), isA(TestSprite));
		}



		[Test]
		public function should_add_multiple_objects():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.add(Sprite)
				.add(Sprite)
				.add(Sprite)
			.end.stop();

			assertThat(_contextView.numChildren, equalTo(3));
		}


		[Test]
		public function should_add_multiple_structures():void {

			_displayTreeBuilder.startWith(_contextView).begin
				.add(Sprite).begin
					.add(TestSprite)
				.end
				.add(Sprite).begin
					.add(TestSprite)
				.end
			.end.stop();



			assertThat(_contextView.numChildren, equalTo(2));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).getChildAt(0), isA(TestSprite));

			assertThat((_contextView.getChildAt(1) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(1) as DisplayObjectContainer).getChildAt(0), isA(TestSprite));

		}



		[Test]
		public function should_add_multiple_objects_with_loop():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.times(12).add(Sprite)
			.end.stop();

			assertThat(_contextView.numChildren, equalTo(12));
		}



		[Test]
		public function should_add_multiple_sub_structures_with_loop():void {
			_displayTreeBuilder.startWith(_contextView).begin
					.times(12).add(Sprite)
					.end.stop();

			assertThat(_contextView.numChildren, equalTo(12));
		}
	}
}

import flash.display.Sprite;


class TestSprite extends Sprite {

}
