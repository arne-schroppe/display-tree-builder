package net.wooga.testingtools {
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;


//TODO (arneschroppe 10/09/2012) turn this into hamcrest matcher. optionally allow arrays of methods and followingMethods
	public class Reflection {


		public function isFollowedBy(value:*, methodName:String, followingMethodName:String):Boolean {

			var description:XML = describeType(value);

			//Find methodName in value
			var method:XML = findMethod(description, methodName);

			if(!method) {
				throw new ArgumentError(methodName + " could not be found");
			}

			if(method.@access == "writeonly") {
				return false;
			}

			//Get it's return type
			var returnTypeName:String = getType(method);

			//See if it contains followingMethodName
			var returnType:Class = getDefinitionByName(returnTypeName) as Class;
			var returnTypeDescription:XML = describeType(returnType);
			var returnTypeMethod:XML = findMethod(returnTypeDescription, followingMethodName)

			return returnTypeMethod != null;
		}


		private function getType(method:XML):* {
			var type:XML = method.@returnType[0];
			if(!type) {
				type = method.@type[0];
			}

			return type;
		}


		private function findMethod(description:XML, methodName:String):XML {
			var method:XML = description..method.(@name == methodName)[0];
			if(!method) {
				method = description..accessor.(@name == methodName)[0];
			}

			return method;
		}
	}
}
