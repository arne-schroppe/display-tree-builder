package {
	import net.wooga.displaytreebuilder.builder.TreeBuilderBugsTest;
	import net.wooga.displaytreebuilder.builder.TreeBuilderErrorsTest;
	import net.wooga.displaytreebuilder.builder.TreeBuilderFeatureTest;
	import net.wooga.displaytreebuilder.builder.TreeBuilderGrammarTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite {

//		[BeforeClass]
//		public static function runBeforeClass():void {
//			CoverageManager.agent.recordCoverage("Start");
//			//LocalConnectionCoverageAgent(CoverageManager.agent).coverageDataConnectionName = "Test";
//			//LocalConnectionCoverageAgent(CoverageManager.agent).initializeAgent();
//		}

		public var displayTreeBuilderFeatureTest:TreeBuilderFeatureTest;
		public var displayTreeBuilderErrorsTest:TreeBuilderErrorsTest;
		public var treeBuilderBugsTest:TreeBuilderBugsTest;
		public var treeBuilderGrammarTest:TreeBuilderGrammarTest;



//		[AfterClass]
//		public static function runAfterClass():void {
//			// run for one time after all test cases
//			CoverageManager.exit();
//			trace("Exiting coverage manager");
//		}
	}
}
