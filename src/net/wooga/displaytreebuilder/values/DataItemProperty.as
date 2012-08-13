package net.wooga.displaytreebuilder.values {
	public class DataItemProperty implements IValue{
		private var _property:String;

		public function DataItemProperty(property:String) {
			_property = property;
		}

		public function getValue(currentDataItem:*):* {
			return currentDataItem[_property];
		}
	}
}
