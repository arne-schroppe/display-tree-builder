package {
	import net.wooga.displaytreebuilder.builder.TreeBuilderBugsTest;
	import net.wooga.displaytreebuilder.builder.TreeBuilderErrorsTest;
	import net.wooga.displaytreebuilder.builder.TreeBuilderFeatureTest;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite {

		public var displayTreeBuilderFeatureTest:TreeBuilderFeatureTest;
		public var displayTreeBuilderErrorsTest:TreeBuilderErrorsTest;
		public var treeBuilderBugsTest:TreeBuilderBugsTest;
	}
}
