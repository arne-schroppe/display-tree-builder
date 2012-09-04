package net.wooga.fixtures {
	import flash.display.Sprite;

	public class MethodsSprite extends Sprite {
		private var _noParamMethodCalled:Boolean;
		private var _oneParamMethodParam1:*;

		public function MethodsSprite() {
		}


		public function get noParamMethodCalled():Boolean {
			return _noParamMethodCalled;
		}

		public function noParamMethod():void {
			_noParamMethodCalled = true;
		}


		public function oneParamMethod(param:*):void {
			_oneParamMethodParam1 = param;
		}

		public function get oneParamMethodParam1():* {
			return _oneParamMethodParam1;
		}
	}
}
