package net.wooga.fixtures {
	import flash.display.Sprite;

	public class MethodsSprite extends Sprite {
		private var _noParamMethodCalled:Boolean;
		private var _oneParamMethodParam1:*;
		private var _twoParamMethodParam1:*;
		private var _twoParamMethodParam2:*;
		private var _multiCallMethodParams:Array = [];

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


		public function twoParamMethod(param1:*, param2:*):void {
			_twoParamMethodParam1 = param1;
			_twoParamMethodParam2 = param2;
		}

		public function multiCallMethod(param:*):void {
			_multiCallMethodParams.push(param);
		}

		public function get oneParamMethodParam1():* {
			return _oneParamMethodParam1;
		}

		public function get twoParamMethodParam1():* {
			return _twoParamMethodParam1;
		}

		public function get twoParamMethodParam2():* {
			return _twoParamMethodParam2;
		}

		public function get multiCallMethodParams():Array {
			return _multiCallMethodParams;
		}
	}
}
