package net.wooga.testingtools {
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;


	public class Reflection {


		public function isFollowedBy(method:Method, followingMethodName:String):Boolean {

			var description:XML = describeType(method.value);

			//Find methodName in value
			var methodXML:XML = findMethod(description, method.methodName);

			if(!methodXML) {
				throw new ArgumentError(method.methodName + " could not be found");
			}

			if(methodXML.@access == "writeonly") {
				return false;
			}

			//Get it's return type
			var returnTypeName:String = getType(methodXML);

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

			if(!method) {
				method = findMethodInImplementedInterfaces(description, methodName);
			}

			return method;
		}

		private function findMethodInImplementedInterfaces(description:XML, methodName:String):XML {
			var method:XML;

			var implementedInterfaces:XMLList = description..implementsInterface.@type;

			for each(var implementedInterfaceXML:XML in implementedInterfaces) {
				var interfaceName:String = implementedInterfaceXML.toString();
				var type:Class = getDefinitionByName(interfaceName) as Class;
				var typeDescription:XML = describeType(type);

				method = findMethod(typeDescription, methodName);
				if(method) {
					break;
				}
			}

			return method;
		}
	}
}
