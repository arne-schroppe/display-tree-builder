package net.wooga.displaytreebuilder.tools {
	import org.as3commons.collections.framework.IIterable;
	import org.as3commons.collections.framework.IIterator;

	public class UnifiedCollection {
		private var _collection:*;

		public function get collection():* {
			return _collection;
		}

		public function get hasContent():Boolean {
			return _collection != null;
		}

		public function UnifiedCollection(collection:*) {

			if(collection is IIterable) {
				storeCollectionInArray(collection);
			}
			else if(collection is IIterator) {
				storeIteratorInArray(collection);
			}
			else {
				storeCollection(collection);
			}

		}



		private function storeCollection(collection:*):void {
			_collection = collection;
		}

		private function storeCollectionInArray(collection:IIterable):void {
			var iterator:IIterator = collection.iterator();
			storeIteratorInArray(iterator);
		}

		private function storeIteratorInArray(iterator:IIterator):void {
			var storage:Array = [];
			while(iterator.hasNext()) {
				storage.push(iterator.next());
			}
			_collection = storage;
		}

	}
}
