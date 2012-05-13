package net.wooga.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import net.wooga.displaytreebuilder.DisplayTree;
	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.as3commons.collections.ArrayList;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;

	public class TreeBuilderFeatureTest {

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
		public function should_add_a_simple_object():void {

			_displayTreeBuilder.uses(_contextView).containing
				.a(TestSprite1)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
		}


		[Test]
		public function should_add_a_name_to_an_object():void {
			_displayTreeBuilder.uses(_contextView).containing
				.a(TestSprite1).withTheName("testname")
			.end.finish();

			assertThat(_contextView.getChildAt(0).name, equalTo("testname"));
		}

		[Test]
		public function should_allow_sub_objects():void {
			_displayTreeBuilder.uses(_contextView).containing
				.a(Sprite).containing
					.a(TestSprite1)
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).getChildAt(0), isA(TestSprite1));
		}



		[Test]
		public function should_allow_containing_after_data_generated_items():void {

			var data:Array = [1]

			_displayTreeBuilder.uses(_contextView).containing
				.a(Sprite).forEveryItemIn(data) .containing
					.a(TestSprite1)
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).getChildAt(0), isA(TestSprite1));
		}



		[Test]
		public function should_allow_containing_after_data_generated_items_with_set_properties():void {

			var data:Array = [1]

			_displayTreeBuilder.uses(_contextView).containing
					.a(Sprite).forEveryItemIn(data)
						.withTheProperty("name").setToThe.item
						.containing
							.a(TestSprite1)
						.end
				.end.finish();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).numChildren, equalTo(1));
			assertThat((_contextView.getChildAt(0) as DisplayObjectContainer).getChildAt(0), isA(TestSprite1));
		}


		[Test]
		public function should_add_multiple_objects():void {
			_displayTreeBuilder.uses(_contextView).containing
				.a(Sprite)
				.a(Sprite)
				.a(Sprite)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
		}


		[Test]
		public function should_add_multiple_structures():void {

			_displayTreeBuilder.uses(_contextView).containing
				.a(Sprite).withTheName("1").containing
					.a(TestSprite1).withTheName("2")
				.end
				.a(Sprite).withTheName("3").containing
					.a(TestSprite1).withTheName("4")
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
			_displayTreeBuilder.uses(_contextView).containing
				.times(12).a(Sprite)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(12));
		}



		[Test]
		public function should_add_multiple_sub_structures_with_loop():void {
			_displayTreeBuilder.uses(_contextView).containing
				.times(3).a(Sprite).containing
					.a(TestSprite1)
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
			_displayTreeBuilder.uses(_contextView).containing
				.times(2).a(Sprite).containing
					.times(2).a(TestSprite1).containing
						.a(TestSprite2)
						.a(TestSprite3)
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

			_displayTreeBuilder.uses(_contextView).containing
				.theInstance(instance1)
				.theInstance(instance2)
			.end.finish();

			assertThat(_contextView.numChildren, equalTo(2));
			assertThat(_contextView.getChildAt(0), equalTo(instance1));
			assertThat(_contextView.getChildAt(1), equalTo(instance2));
		}


		[Test]
		public function should_add_instances_with_sub_structures():void {
			var instance1:DisplayObject = new TestSprite1();
			var instance2:DisplayObject = new TestSprite2();

			_displayTreeBuilder.uses(_contextView).containing
				.theInstance(instance1).withTheName("1").containing
					.a(TestSprite1).withTheName("2")
				.end
				.theInstance(instance2).withTheName("3").containing
					.a(TestSprite1).withTheName("4")
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


		//TODO (arneschroppe 31/1/12) also allow using dictionaries, maps and objects ??

		[Test]
		public function should_initialize_from_data_array():void {

			var dataArray:Array = [
				{"field": "1"},
				{"field": "2"},
				{"field": "3"}
			];

			_displayTreeBuilder.uses(_contextView).containing
				.a(TestSprite1).forEveryItemIn(dataArray)
					.withTheProperty("name").setToThe.itemProperty("field")

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
		public function should_initialize_from_data_vector():void {

			var data:Vector.<String> = new <String>[
				"1",
				"2",
				"3"

			];

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(data)
					.withTheProperty("name").setToThe.item
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

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(dataArray)
						.withTheProperty("name").setToThe.item

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
		public function should_use_arbitrary_value_when_initializing_from_collection():void {
			var dataArray:Array = [
				"herp",
				"derp",
				"wat"
			];

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(dataArray)
						.withTheProperty("name").setToThe.value("SUCCESS")
					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));

			assertThat(_contextView.getChildAt(0).name, equalTo("SUCCESS"));
			assertThat(_contextView.getChildAt(1).name, equalTo("SUCCESS"));
			assertThat(_contextView.getChildAt(2).name, equalTo("SUCCESS"));
		}



		[Test]
		public function should_initialize_from_collection():void {

			var data:ArrayList = new ArrayList();
			data.add({"field":"1"});
			data.add({"field":"2"});
			data.add({"field":"3"});


			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(data)
						.withTheProperty("name").setToThe.itemProperty("field")

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


			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(data.iterator())
						.withTheProperty("name").setToThe.itemProperty("field")
				.end.finish()

			assertThat(_contextView.numChildren, equalTo(3));

			assertThat(_contextView.getChildAt(0), isA(TestSprite1));
			assertThat(_contextView.getChildAt(1), isA(TestSprite1));
			assertThat(_contextView.getChildAt(2), isA(TestSprite1));

			assertThat(_contextView.getChildAt(0).name, equalTo("1"));
			assertThat(_contextView.getChildAt(1).name, equalTo("2"));
			assertThat(_contextView.getChildAt(2).name, equalTo("3"));

		}


		[Test]
		public function should_initialize_from_collection_multiple_times():void {


			var data:Array = [
				{"field":"1"},
				{"field":"2"}
			];

			_displayTreeBuilder.uses(_contextView).containing.
					times(2).a(TestSprite1).forEveryItemIn(data)
						.withTheProperty("name").setToThe.itemProperty("field")
				.end.finish();

			assertThat(_contextView.numChildren, equalTo(4));

			assertThat(_contextView.getChildAt(0), allOf(isA(TestSprite1), hasPropertyWithValue("name", "1")));
			assertThat(_contextView.getChildAt(1), allOf(isA(TestSprite1), hasPropertyWithValue("name", "2")));
			assertThat(_contextView.getChildAt(2), allOf(isA(TestSprite1), hasPropertyWithValue("name", "1")));
			assertThat(_contextView.getChildAt(3), allOf(isA(TestSprite1), hasPropertyWithValue("name", "2")));

		}


		[Test]
		public function should_allow_setting_of_constructor_arguments():void {


			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite)
						.withTheConstructorArguments("testprop", -129873)
				.end.finish();

			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
		}




		[Test]
		public function should_allow_setting_of_constructor_arguments_with_collection():void {

			var data:Array = ["a", "b", "c"];

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).withTheConstructorArguments("testprop", -129873)
						.forEveryItemIn(data)
							.withTheProperty("name").setToThe.item
					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("name", "a"), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("name", "b"), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
			assertThat(_contextView.getChildAt(2), allOf(isA(CtorTestSprite), hasPropertyWithValue("name", "c"), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
		}



		[Test]
		public function should_allow_setting_of_constructor_arguments_with_content():void {

			_displayTreeBuilder.uses(_contextView).containing
				.a(CtorTestSprite).withTheConstructorArguments("test2", -78686).containing
					.a(TestSprite1)
				.end
			.end.finish();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "test2"), hasPropertyWithValue("prop2", -78686)));

			assertThat(Sprite(_contextView.getChildAt(0)).numChildren, equalTo(1));
			assertThat(Sprite(_contextView.getChildAt(0)).getChildAt(0), isA(TestSprite1));
		}



		[Test]
		public function should_allow_nesting_of_constructor_arguments():void {

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).withTheConstructorArguments("test2", -78686).containing
						.a(CtorTestSprite).withTheConstructorArguments("nested", 1233243)
					.end
				.end.finish();


			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "test2"), hasPropertyWithValue("prop2", -78686)));

			assertThat(Sprite(_contextView.getChildAt(0)).numChildren, equalTo(1));
			assertThat(Sprite(_contextView.getChildAt(0)).getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "nested"), hasPropertyWithValue("prop2", 1233243)));
		}




		[Test]
		public function should_allow_nesting_of_constructor_arguments_with_another_ctor_afterwards():void {

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).withTheConstructorArguments("test2", -78686).containing
						.a(CtorTestSprite).withTheConstructorArguments("nested", 1233243)
					.end
					.a(CtorTestSprite).withTheConstructorArguments("sequence", 3746)
				.end.finish();


			assertThat(_contextView.numChildren, equalTo(2));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "test2"), hasPropertyWithValue("prop2", -78686)));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "sequence"), hasPropertyWithValue("prop2", 3746)));

			assertThat(Sprite(_contextView.getChildAt(0)).numChildren, equalTo(1));
			assertThat(Sprite(_contextView.getChildAt(0)).getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "nested"), hasPropertyWithValue("prop2", 1233243)));
		}



		//TODO (arneschroppe 13/05/2012) we should also be able to set a specific constructor arg to the item or item-property


		[Test]
		public function should_allow_setting_item_property_after_setting_value():void {

			var dataArray:Array = [
				100,
				200,
				300
			];


			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).forEveryItemIn(dataArray)
						.withTheProperty("name").setToThe.value("Some Name")
						.withTheProperty("x").setToThe.item

					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(isA(TestSprite1), hasPropertyWithValue("name", "Some Name"), hasPropertyWithValue("x", 100)));
			assertThat(_contextView.getChildAt(1), allOf(isA(TestSprite1), hasPropertyWithValue("name", "Some Name"), hasPropertyWithValue("x", 200)));
			assertThat(_contextView.getChildAt(2), allOf(isA(TestSprite1), hasPropertyWithValue("name", "Some Name"), hasPropertyWithValue("x", 300)));
		}


		


		[Test]
		public function should_store_instances_in_array():void {

			var instances:Array = [];

			_displayTreeBuilder.uses(_contextView).containing
				.a(TestSprite1).whichWillBeStoredIn(instances)
				.a(TestSprite2).whichWillBeStoredIn(instances)
				.a(TestSprite3).whichWillBeStoredIn(instances)
			.end.finish();


			assertThat(instances.length, equalTo(3));
			assertThat(instances[0], isA(TestSprite1));
			assertThat(instances[1], isA(TestSprite2));
			assertThat(instances[2], isA(TestSprite3));

		}


		[Test]
		public function should_allow_to_set_a_property_on_created_objects():void {

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite2).withTheProperty("testProperty").setToThe.value("foo")
					.a(TestSprite2).withTheProperty("testProperty2").setToThe.value("bar")
					.a(TestSprite2)
				.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(hasPropertyWithValue("testProperty", "foo"), hasPropertyWithValue("testProperty2", "")));
			assertThat(_contextView.getChildAt(1), allOf(hasPropertyWithValue("testProperty", ""), hasPropertyWithValue("testProperty2", "bar")));
			assertThat(_contextView.getChildAt(2), allOf(hasPropertyWithValue("testProperty", ""), hasPropertyWithValue("testProperty2", "")));

		}
 	}
}

import flash.display.Sprite;

class TestSprite1 extends Sprite {


}

class TestSprite2 extends Sprite {

	public var testProperty:String = "";
	public var testProperty2:String = "";

}

class TestSprite3 extends Sprite {

}



class CtorTestSprite extends Sprite {

	private var _prop1:String;
	private var _prop2:int;


	public function CtorTestSprite(prop1:String, prop2:int) {
		_prop1 = prop1;
		_prop2 = prop2;
	}


	public function get prop1():String {
		return _prop1;
	}

	public function get prop2():int {
		return _prop2;
	}


}
