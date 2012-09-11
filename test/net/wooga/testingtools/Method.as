package net.wooga.testingtools {
	import flash.utils.getQualifiedClassName;

	public class Method {
		private var _value:Object;
		private var _methodName:String;

		public function Method(value:Object, methodName:String) {
			_value = value;
			_methodName = methodName;
		}

		public function get value():Object {
			return _value;
		}

		public function get methodName():String {
			return _methodName;
		}


		public function toString():String {
			return "'" + methodName + "' in " + getQualifiedClassName(value);
		}
	}
}
