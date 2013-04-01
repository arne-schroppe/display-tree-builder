package net.wooga.testingtools {
	import flash.display.Stage;

	import mx.core.FlexGlobals;

	public function TestStage():Stage {

		var app:Object = FlexGlobals.topLevelApplication;

		return mx.core.Application(app).stage;

		/*
		 if (app is mx.core.Application) {
		 return mx.core.Application(app).stage;
		 } else if (app is spark.components.Application) {
		 return spark.components.Application(app).stage;
		 } else {
		 return null;
		 }
		 */

	}
}
