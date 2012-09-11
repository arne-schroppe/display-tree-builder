package net.wooga.testingtools.hamcrest {
	import flash.utils.getQualifiedClassName;

	import net.wooga.testingtools.Method;
	import net.wooga.testingtools.Reflection;

	import org.hamcrest.Description;
	import org.hamcrest.TypeSafeDiagnosingMatcher;

	public class IsFollowedByMethodMatcher extends TypeSafeDiagnosingMatcher {
		private var _followingMethodName:String;
		private var _reflection:Reflection;

		public function IsFollowedByMethodMatcher(followingMethodName:String) {
			super(Method);
			_followingMethodName = followingMethodName;
			_reflection = new Reflection();
		}


		override public function matchesSafely(methodObj:Object, description:Description):Boolean {
			var method:Method = methodObj as Method;

			var isFollowing:Boolean = _reflection.isFollowedBy(method, _followingMethodName);

			if(!isFollowing) {
				description.appendText("'" + _followingMethodName + "' does not follow " + method.toString);
			}

			return isFollowing;
		}




		override public function describeTo(description:Description):void {
			description.appendText("'" + _followingMethodName + "' to be callable next");
		}

	}
}
