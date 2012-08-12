package net.wooga.displaytreebuilder.values {
	public class StaticValue implements IValue{
		private var _value:*;

		public function StaticValue(value:*) {
			_value = value;
		}

		public function getValue(currentDataItem:*):* {
			return _value;
		}
	}
}
