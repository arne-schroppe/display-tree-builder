package net.wooga.testingtools.hamcrest {
	public function isFollowedBy(followingMethodName:String):IsFollowedByMethodMatcher {
		return new IsFollowedByMethodMatcher(followingMethodName);
	}
}
