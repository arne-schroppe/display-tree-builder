package net.wooga.fixtures {
	import flash.display.Sprite;

	public class CtorTestSprite extends Sprite {

		private var _prop1:String;
		private var _prop2:*;


		public function CtorTestSprite(prop1:String, prop2:*) {
			_prop1 = prop1;
			_prop2 = prop2;
		}


		public function get prop1():String {
			return _prop1;
		}

		public function get prop2():* {
			return _prop2;
		}


	}
}
