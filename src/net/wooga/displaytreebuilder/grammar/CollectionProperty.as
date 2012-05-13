package net.wooga.displaytreebuilder.grammar {
	public interface CollectionProperty {
		function withTheProperty(propertyName:String):_setToThe;
		function withTheConstructorArguments(...args):BlockContent$InstanceModification;
	}
}
