package net.wooga.displaytreebuilder.builder {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	import net.wooga.displaytreebuilder.DisplayTree;
	import net.wooga.fixtures.CtorTestSprite;
	import net.wooga.fixtures.MethodsSprite;
	import net.wooga.fixtures.TestSprite1;
	import net.wooga.fixtures.TestSprite2;
	import net.wooga.fixtures.TestSprite3;
	import net.wooga.utils.flexunit.FlexUnitUtils;

	import org.as3commons.collections.ArrayList;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;
	import org.hamcrest.assertThat;
	import org.hamcrest.core.allOf;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasPropertyWithValue;
	import org.hamcrest.object.notNullValue;
	import org.hamcrest.object.strictlyEqualTo;

	public class TreeBuilderFeatureTest {

		private var _contextView:Sprite;

		private var _displayTreeBuilder:DisplayTree;


//		[BeforeClass]
//		public static function setUpClass():void {
//			_contextView = new Sprite();
//			FlexUnitUtils.stage.addChild(_contextView);
//
//			_displayTreeBuilder = new DisplayTree();
//		}
//
//
//
//		[Before]
//		public function setUp():void {
//			while(_contextView.numChildren > 0) {
//				_contextView.removeChildAt(0);
//			}
//		}



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
		public function should_set_property_to_value():void {

			var name:String = "abcde";

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1)
						.withTheProperty("name").setToThe.value(name)
					.end.finish();

			var firstSprite:TestSprite1 = TestSprite1(_contextView.getChildAt(0));
			assertThat(firstSprite.name, equalTo(name));
		}



		[Test]
		public function should_set_property_for_instance_to_value():void {

			var testSprite:TestSprite1 = new TestSprite1();
			var name:String = "abcde";

			assertThat(testSprite.name, not(equalTo(name)));

			_displayTreeBuilder.uses(_contextView).containing
					.theInstance(testSprite)
						.withTheProperty("name").setToThe.value(name)
					.end.finish();

			assertThat(testSprite.name, equalTo(name));
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
						.constructedWith.theValue("testprop").theValue(-129873)
				.end.finish();

			assertThat(_contextView.numChildren, equalTo(1));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
		}




		[Test]
		public function should_allow_setting_of_constructor_arguments_with_collection():void {

			var data:Array = ["a", "b", "c"];

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).constructedWith.theValue("testprop").theValue(-129873)
						.forEveryItemIn(data)
							.withTheProperty("name").setToThe.item
					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("name", "a"), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("name", "b"), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
			assertThat(_contextView.getChildAt(2), allOf(isA(CtorTestSprite), hasPropertyWithValue("name", "c"), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", -129873)));
		}



		[Test]
		public function should_allow_setting_of_constructor_arguments_with_data_definitions():void {

			var data:Array = ["a", "b", "c"];

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).forEveryItemIn(data)
						.constructedWith.theValue("testprop").theItem
					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", "a")));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", "b")));
			assertThat(_contextView.getChildAt(2), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", "c")));
		}



		[Test]
		public function should_allow_setting_of_constructor_arguments_with_item_values():void {

			var data:Array = [{"val": "a"}, {"val": "b"}, {"val": "c"}];

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).forEveryItemIn(data)
						.constructedWith.theValue("testprop").theItemProperty("val")
					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", "a")));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", "b")));
			assertThat(_contextView.getChildAt(2), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "testprop"), hasPropertyWithValue("prop2", "c")));
		}


		[Test]
		public function should_allow_setting_the_data_item_several_times_in_constructor():void {

			var data:Array = ["a", "b", "c"];

			_displayTreeBuilder.uses(_contextView).containing
					.a(CtorTestSprite).forEveryItemIn(data)
						.constructedWith.theItem.theValue("Test123").theItem
					.end.finish();

			assertThat(_contextView.numChildren, equalTo(3));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "a"), hasPropertyWithValue("prop2", "Test123"), hasPropertyWithValue("prop3", "a")));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "b"), hasPropertyWithValue("prop2", "Test123"), hasPropertyWithValue("prop3", "b")));
			assertThat(_contextView.getChildAt(2), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "c"), hasPropertyWithValue("prop2", "Test123"), hasPropertyWithValue("prop3", "c")));
		}

		[Test]
		public function should_allow_setting_of_constructor_arguments_with_content():void {

			_displayTreeBuilder.uses(_contextView).containing
				.a(CtorTestSprite).constructedWith.theValue("test2").theValue(-78686)
				.containing
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
					.a(CtorTestSprite).constructedWith.theValue("test2").theValue(-78686).containing
						.a(CtorTestSprite).constructedWith.theValue("nested").theValue(1233243)
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
					.a(CtorTestSprite).constructedWith.theValue("test2").theValue(-78686).containing
						.a(CtorTestSprite).constructedWith.theValue("nested").theValue(1233243)
					.end
					.a(CtorTestSprite).constructedWith.theValue("sequence").theValue(3746)
				.end.finish();


			assertThat(_contextView.numChildren, equalTo(2));
			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "test2"), hasPropertyWithValue("prop2", -78686)));
			assertThat(_contextView.getChildAt(1), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "sequence"), hasPropertyWithValue("prop2", 3746)));

			assertThat(Sprite(_contextView.getChildAt(0)).numChildren, equalTo(1));
			assertThat(Sprite(_contextView.getChildAt(0)).getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "nested"), hasPropertyWithValue("prop2", 1233243)));
		}


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


//		[Test]
//		public function should_allow_calling_of_methods():void {
//
//			_displayTreeBuilder.uses(_contextView).containing
//					.a(InitTestSprite)
//						.withTheMethod("init").calledWith.param("test string").param(3294).theItem.param(-1)
//						.withTheMethod("init").calledWith("test string", 3294, theItem())
//						.withTheMethod("init").calledWithArgs("test string", 3294).theItem().args(-1, "abcde")
//					.end.finish();
//
//			assertThat(_contextView.numChildren, equalTo(1));
//			assertThat(_contextView.getChildAt(0), allOf(isA(CtorTestSprite), hasPropertyWithValue("prop1", "test string"), hasPropertyWithValue("prop2", 3294)));
//
//		}


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


		[Test]
		public function should_provide_post_construct_functions():void {
			var instances:Array = [];

			var initializedElement:DisplayObject = null;

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite2)
					.a(TestSprite1).whichWillBeStoredIn(instances).withTheInitializationFunction(function(element:DisplayObject):void{ initializedElement = element })
					.a(TestSprite2)
				.end.finish();

			assertThat(initializedElement, notNullValue());
			assertThat(initializedElement, strictlyEqualTo(instances[0]));
		}




		[Test]
		public function should_call_init_function_after_the_element_was_added_to_stage():void {

			var wasAddedToStage:Boolean = false;

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite2)
					.a(TestSprite1).withTheInitializationFunction(function(element:DisplayObject):void{ wasAddedToStage = element.parent !== null })
					.a(TestSprite2)
					.end.finish();

			assertThat(wasAddedToStage, equalTo(true));
		}





		[Test]
		public function should_execute_init_function_after_all_other_properties_have_been_set():void {

			var data:Array = ["1", "2", "3", "4"];
			var pointer:int = 0;

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite2)
					.a(TestSprite2) .forEveryItemIn(data)
						.withTheProperty("testProperty").setToThe.item
						.withTheInitializationFunction(function(element:TestSprite2):void{ assertThat(element.testProperty, equalTo(data[pointer])); ++pointer })
					.a(TestSprite2)
				.end.finish();


			assertThat(pointer, equalTo(data.length));

		}

		[Test]
		public function should_allow_multiple_init_functions_which_are_called_in_order():void {

			var instances:Array = [];

			var calledInitFunctions:Array = [];

			_displayTreeBuilder.uses(_contextView).containing
					.a(TestSprite1).whichWillBeStoredIn(instances)
						.withTheInitializationFunction(function(element:DisplayObject):void{ calledInitFunctions.push(1) })
						.withTheInitializationFunction(function(element:DisplayObject):void{ calledInitFunctions.push(2) })
						.withTheInitializationFunction(function(element:DisplayObject):void{ calledInitFunctions.push(3) })

					.a(TestSprite2)
				.end.finish();

			assertThat(calledInitFunctions.length, equalTo(3));
			assertThat(calledInitFunctions[0], equalTo(1));
			assertThat(calledInitFunctions[1], equalTo(2));
			assertThat(calledInitFunctions[2], equalTo(3));
		}



		[Test]
		public function should_allow_multiple_init_functions_with_instances_which_are_called_in_order():void {

			var calledInitFunctions:Array = [];

			var instance:TestSprite1 = new TestSprite1();

			_displayTreeBuilder.uses(_contextView).containing
					.theInstance(instance)
						.withTheInitializationFunction(function(element:DisplayObject):void{ calledInitFunctions.push(1) })
						.withTheInitializationFunction(function(element:DisplayObject):void{ calledInitFunctions.push(2) })
						.withTheInitializationFunction(function(element:DisplayObject):void{ calledInitFunctions.push(3) })
					.end.finish();

			assertThat(calledInitFunctions.length, equalTo(3));
			assertThat(calledInitFunctions[0], equalTo(1));
			assertThat(calledInitFunctions[1], equalTo(2));
			assertThat(calledInitFunctions[2], equalTo(3));
		}



		[Test]
		public function should_call_a_method_with_no_params():void {
			_displayTreeBuilder.uses(_contextView).containing
					.a(MethodsSprite)
						.withTheMethod("noParamMethod").calledWithNoParams
				.end.finish();

			var firstSprite:MethodsSprite = MethodsSprite(_contextView.getChildAt(0));
			assertThat(firstSprite.noParamMethodCalled, equalTo(true));
		}


		[Test]
		public function should_call_method_with_value():void {

			var param:String = "Test1234";

			_displayTreeBuilder.uses(_contextView).containing
					.a(MethodsSprite)
						.withTheMethod("oneParamMethod").calledWith.theValue(param)
				.end.finish();

			var firstSprite:MethodsSprite = MethodsSprite(_contextView.getChildAt(0));
			assertThat(firstSprite.noParamMethodCalled, equalTo(false));
			assertThat(firstSprite.oneParamMethodParam1, equalTo(param));
		}


		[Test]
		public function should_call_method_with_item():void {


			_displayTreeBuilder.uses(_contextView).containing
					.a(MethodsSprite).forEveryItemIn(["a", "b", "c"])
						.withTheMethod("oneParamMethod").calledWith.theItem
					.end.finish();

			var spriteA:MethodsSprite = MethodsSprite(_contextView.getChildAt(0));
			assertThat(spriteA.oneParamMethodParam1, equalTo("a"));

			var spriteB:MethodsSprite = MethodsSprite(_contextView.getChildAt(1));
			assertThat(spriteB.oneParamMethodParam1, equalTo("b"));


			var spriteC:MethodsSprite = MethodsSprite(_contextView.getChildAt(2));
			assertThat(spriteC.oneParamMethodParam1, equalTo("c"));

		}





		[Test]
		public function should_call_method_with_item_property():void {


			_displayTreeBuilder.uses(_contextView).containing
					.a(MethodsSprite).forEveryItemIn([{"prop": "a"}, {"prop": "b"}, {"prop": "c"}])
					.withTheMethod("oneParamMethod").calledWith.theItemProperty("prop")
				.end.finish();

			var spriteA:MethodsSprite = MethodsSprite(_contextView.getChildAt(0));
			assertThat(spriteA.oneParamMethodParam1, equalTo("a"));

			var spriteB:MethodsSprite = MethodsSprite(_contextView.getChildAt(1));
			assertThat(spriteB.oneParamMethodParam1, equalTo("b"));


			var spriteC:MethodsSprite = MethodsSprite(_contextView.getChildAt(2));
			assertThat(spriteC.oneParamMethodParam1, equalTo("c"));

		}




		[Test]
		public function should_call_method_with_two_values():void {

			var value:String = "Test1234";

			_displayTreeBuilder.uses(_contextView).containing
					.a(MethodsSprite).forEveryItemIn(["a", "b", "c"])
						.withTheMethod("twoParamMethod").calledWith
							.theItem
							.theValue(value)
					.end.finish();

			var spriteA:MethodsSprite = MethodsSprite(_contextView.getChildAt(0));
			assertThat(spriteA.twoParamMethodParam1, equalTo("a"));
			assertThat(spriteA.twoParamMethodParam2, equalTo(value));

			var spriteB:MethodsSprite = MethodsSprite(_contextView.getChildAt(1));
			assertThat(spriteB.twoParamMethodParam1, equalTo("b"));
			assertThat(spriteB.twoParamMethodParam2, equalTo(value));

			var spriteC:MethodsSprite = MethodsSprite(_contextView.getChildAt(2));
			assertThat(spriteC.twoParamMethodParam1, equalTo("c"));
			assertThat(spriteC.twoParamMethodParam2, equalTo(value));

		}


		[Test]
		public function should_call_a_method_with_no_params_on_a_prebuilt_instance():void {

			var firstSprite:MethodsSprite = new MethodsSprite();

			_displayTreeBuilder.uses(_contextView).containing
					.theInstance(firstSprite)
						.withTheMethod("noParamMethod").calledWithNoParams
					.end.finish();

			assertThat(firstSprite.noParamMethodCalled, equalTo(true));
		}


		[Test]
		public function should_call_method_with_value_on_a_prebuilt_instance():void {

			var param:String = "Test1234";
			var firstSprite:MethodsSprite = new MethodsSprite();

			_displayTreeBuilder.uses(_contextView).containing
					.theInstance(firstSprite)
						.withTheMethod("oneParamMethod").calledWith.theValue(param)
					.end.finish();

			assertThat(firstSprite.noParamMethodCalled, equalTo(false));
			assertThat(firstSprite.oneParamMethodParam1, equalTo(param));
		}
 	}
}
