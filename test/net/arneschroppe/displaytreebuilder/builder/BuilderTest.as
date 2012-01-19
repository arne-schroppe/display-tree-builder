package net.arneschroppe.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.as3commons.collections.ArrayList;

	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.core.throws;
	import org.hamcrest.object.equalTo;

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
				.add(TestSprite1)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
		}


		[Test]
		public function should_add_a_name_to_an_object():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.add(TestSprite1).withName("testname")
			.end.finish();

			assertThat(_contextView.getChildAt(0).name, equalTo("testname"));
		}

		[Test]
		public function should_allow_sub_objects():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.add(Sprite).begin
					.add(TestSprite1)
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).getChildAt(0), isA(TestSprite1));
		}



		[Test]
		public function should_add_multiple_objects():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.add(Sprite)
				.add(Sprite)
				.add(Sprite)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
		}


		[Test]
		public function should_add_multiple_structures():void {

			_displayTreeBuilder.startWith(_contextView).begin
				.add(Sprite).withName("1").begin
					.add(TestSprite1).withName("2")
				.end
				.add(Sprite).withName("3").begin
					.add(TestSprite1).withName("4")
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(2));

			var firstChild:DisplayObjectContainer = _contextView.getChildAt(0) as DisplayObjectContainer;
			assertThat(firstChild.numChildren, equalTo(1));
			assertThat(firstChild.name, equalTo("1"));
			assertThat(firstChild.getChildAt(0), isA(TestSprite1));
			assertThat(firstChild.getChildAt(0).name, equalTo("2"));

			var secondChild:DisplayObjectContainer = _contextView.getChildAt(1) as DisplayObjectContainer;
			assertThat(secondChild.numChildren, equalTo(1));
			assertThat(secondChild.name, equalTo("3"));
			assertThat(secondChild.getChildAt(0), isA(TestSprite1));
			assertThat(secondChild.getChildAt(0).name, equalTo("4"));

		}



		[Test]
		public function should_add_multiple_objects_with_loop():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.times(12).add(Sprite)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(12));
		}



		[Test]
		public function should_add_multiple_sub_structures_with_loop():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.times(3).add(Sprite).begin
					.add(TestSprite1)
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(3));

			var firstChild:DisplayObjectContainer = _contextView.getChildAt(0) as DisplayObjectContainer;
			assertThat(firstChild.numChildren, equalTo(1));
			assertThat(firstChild, isA(Sprite));
			assertThat(firstChild.getChildAt(0), isA(TestSprite1));

			var secondChild:DisplayObjectContainer = _contextView.getChildAt(1) as DisplayObjectContainer;
			assertThat(secondChild.numChildren, equalTo(1));
			assertThat(secondChild, isA(Sprite));
			assertThat(secondChild.getChildAt(0), isA(TestSprite1));

			var thirdChild:DisplayObjectContainer = _contextView.getChildAt(2) as DisplayObjectContainer;
			assertThat(thirdChild.numChildren, equalTo(1));
			assertThat(thirdChild, isA(Sprite));
			assertThat(thirdChild.getChildAt(0), isA(TestSprite1));
		}


		[Test]
		public function should_add_multiple_nested_sub_structures_with_loop():void {
			_displayTreeBuilder.startWith(_contextView).begin
				.times(2).add(Sprite).begin
					.times(2).add(TestSprite1).begin
						.add(TestSprite2)
						.add(TestSprite3)
					.end
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(2));

			var firstChild:DisplayObjectContainer = _contextView.getChildAt(0) as DisplayObjectContainer;
			assertThat(firstChild.numChildren, equalTo(2));
			assertThat(firstChild, isA(Sprite));

			var firstFirstChild:DisplayObjectContainer = firstChild.getChildAt(0) as DisplayObjectContainer;
			assertThat(firstFirstChild, isA(TestSprite1));
			assertThat(firstFirstChild.numChildren, equalTo(2));
			assertThat(firstFirstChild.getChildAt(0), isA(TestSprite2));
			assertThat(firstFirstChild.getChildAt(1), isA(TestSprite3));


			var firstSecondChild:DisplayObjectContainer = firstChild.getChildAt(1) as DisplayObjectContainer;
			assertThat(firstSecondChild, isA(TestSprite1));
			assertThat(firstSecondChild.numChildren, equalTo(2));
			assertThat(firstSecondChild.getChildAt(0), isA(TestSprite2));
			assertThat(firstSecondChild.getChildAt(1), isA(TestSprite3));



			var secondChild:DisplayObjectContainer = _contextView.getChildAt(1) as DisplayObjectContainer;
			assertThat(secondChild.numChildren, equalTo(2));
			assertThat(secondChild, isA(Sprite));

			var secondFirstChild:DisplayObjectContainer = secondChild.getChildAt(0) as DisplayObjectContainer;
			assertThat(secondFirstChild, isA(TestSprite1));
			assertThat(secondFirstChild.numChildren, equalTo(2));
			assertThat(secondFirstChild.getChildAt(0), isA(TestSprite2));
			assertThat(secondFirstChild.getChildAt(1), isA(TestSprite3));


			var secondSecondChild:DisplayObjectContainer = secondChild.getChildAt(1) as DisplayObjectContainer;
			assertThat(secondSecondChild, isA(TestSprite1));
			assertThat(secondSecondChild.numChildren, equalTo(2));
			assertThat(secondSecondChild.getChildAt(0), isA(TestSprite2));
			assertThat(secondSecondChild.getChildAt(1), isA(TestSprite3));

		}


		[Test]
		public function should_add_instances():void {
			var instance1:DisplayObject = new TestSprite1();
			var instance2:DisplayObject = new TestSprite2();

			_displayTreeBuilder.startWith(_contextView).begin
				.addInstance(instance1)
				.addInstance(instance2)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(2));
			assertThat(_contextView.getChildAt(0), equalTo(instance1));
			assertThat(_contextView.getChildAt(1), equalTo(instance2));
		}


		[Test]
		public function should_add_instances_with_sub_structures():void {
			var instance1:DisplayObject = new TestSprite1();
			var instance2:DisplayObject = new TestSprite2();

			_displayTreeBuilder.startWith(_contextView).begin
				.addInstance(instance1).withName("1").begin
					.add(TestSprite1).withName("2")
				.end
				.addInstance(instance2).withName("3").begin
					.add(TestSprite1).withName("4")
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(2));

			var firstChild:DisplayObjectContainer = _contextView.getChildAt(0) as DisplayObjectContainer;
			assertThat(firstChild, equalTo(instance1));
			assertThat(firstChild.numChildren, equalTo(1));
			assertThat(firstChild.name, equalTo("1"));
			assertThat(firstChild.getChildAt(0), isA(TestSprite1));
			assertThat(firstChild.getChildAt(0).name, equalTo("2"));

			var secondChild:DisplayObjectContainer = _contextView.getChildAt(1) as DisplayObjectContainer;
			assertThat(secondChild, equalTo(instance2));
			assertThat(secondChild.numChildren, equalTo(1));
			assertThat(secondChild.name, equalTo("3"));
			assertThat(secondChild.getChildAt(0), isA(TestSprite1));
			assertThat(secondChild.getChildAt(0).name, equalTo("4"));
		}


		[Test]
		public function should_initialize_from_data_array():void {

			var dataArray:Array = [
				{"field": "1"},
				{"field": "2"},
				{"field": "3"}
			];

			_displayTreeBuilder.startWith(_contextView).begin
				.useItemsIn(dataArray).toAddObjectsOfType(TestSprite1)
					.setObjectProperty("name").toItemField("field")
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));

			assertThat(_contextView.getChildAt(0).name, equalTo("1"));
			assertThat(_contextView.getChildAt(1).name, equalTo("2"));
			assertThat(_contextView.getChildAt(2).name, equalTo("3"));

		}


		[Test]
		public function should_use_respective_collection_item_when_initializing_from_collection():void {
			var dataArray:Array = [
				"herp",
				"derp",
				"wat"
			];

			_displayTreeBuilder.startWith(_contextView).begin
					.useItemsIn(dataArray).toAddObjectsOfType(TestSprite1)
						.setObjectProperty("name").toRespectiveItem
				.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));

			assertThat(_contextView.getChildAt(0).name, equalTo("herp"));
			assertThat(_contextView.getChildAt(1).name, equalTo("derp"));
			assertThat(_contextView.getChildAt(2).name, equalTo("wat"));
		}


		[Test]
		public function should_initialize_from_collection():void {

			var data:ArrayList = new ArrayList();
			data.add({"field":"1"});
			data.add({"field":"2"});
			data.add({"field":"3"});


			_displayTreeBuilder.startWith(_contextView).begin
				.useItemsIn(data).toAddObjectsOfType(TestSprite1)
					.setObjectProperty("name").toItemField("field")
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));

			assertThat(_contextView.getChildAt(0).name, equalTo("1"));
			assertThat(_contextView.getChildAt(1).name, equalTo("2"));
			assertThat(_contextView.getChildAt(2).name, equalTo("3"));

		}



		[Test]
		public function should_initialize_from_iterator():void {

			var data:ArrayList = new ArrayList();
			data.add({"field":"1"});
			data.add({"field":"2"});
			data.add({"field":"3"});


			_displayTreeBuilder.startWith(_contextView).begin
					.useItemsIn(data.iterator()).toAddObjectsOfType(TestSprite1)
						.setObjectProperty("name").toItemField("field")
				.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));

			assertThat(_contextView.getChildAt(0).name, equalTo("1"));
			assertThat(_contextView.getChildAt(1).name, equalTo("2"));
			assertThat(_contextView.getChildAt(2).name, equalTo("3"));

		}

		//TODO (arneschroppe 21/12/11) also make it possible to set ctor arguments
		/*
		 _displayTreeBuilder.startWith(_contextView).begin
		 	.usElementsIn(dataArray).toAddObjectsOfType(Sprite)
		 		.setConstructorArgument(1).fromDataField("field")
		 .end.finish();

		* */


		[Test]
		public function should_store_instances_in_array():void {

			var instances:Array = [];

			_displayTreeBuilder.startWith(_contextView).begin
				.add(TestSprite1).andStoreInstanceIn(instances)
				.add(TestSprite2).andStoreInstanceIn(instances)
				.add(TestSprite3).andStoreInstanceIn(instances)
			.end.finish();


			assertThat(instances.length, equalTo(3));
			assertThat(instances[0], isA(TestSprite1));
			assertThat(instances[1], isA(TestSprite2));
			assertThat(instances[2], isA(TestSprite3));

		}


		[Test]
		public function should_throw_exception_for_unfinished_invocations():void {

			_displayTreeBuilder.startWith(_contextView).begin
				.add(TestSprite1)
			.end //not finished


			assertThat(
					function ():void {
						_displayTreeBuilder.startWith(_contextView)
					}, throws(isA(Error))
			);
		}


		[Test]
		public function should_unfinished_invocation_check_should_be_optional():void {

			_displayTreeBuilder.startWith(_contextView).begin
					.add(TestSprite1)
					.end //not finished


			assertThat(
					function ():void {
						_displayTreeBuilder.isCheckingUnfinishedStatements = false;
						_displayTreeBuilder.startWith(_contextView)
					}, not(throws(isA(Error)))
			);
		}

		[Test]
		public function should_throw_error_for_unaligned_begin_and_end():void {

			assertThat(function():void {
				_displayTreeBuilder.startWith(_contextView).begin
						.add(TestSprite1).begin
							.add(TestSprite2)
						//missing 'end'
					.end.finish()
			}, throws(isA(Error)))


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
