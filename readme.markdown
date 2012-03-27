#Display Tree

A declarative language to set up trees of display objects.

###Example

    var treeBuilder:TreeBuilder = new TreeBuilder();

    treeBuilder. uses(rootView). containing.

    	//Adds a Sprite with the name "Menu", containing one
    	//instance of each FullScreenButton and EditButton
    	a (Sprite). withTheName ("Menu"). containing.
    		a (FullScreenButton).
    		an (EditButton).
    	end.

    	//Adds 3 instances of Container, each with
    	//a single instance of Icon
    	times (3). a (Container). containing.
    		an (Icon).
    	end.
    end.finish();

The DSL only allows terms where they make sense (e.g. you can not place
`withName` after `times(x)`). This is especially useful in IDEs with
code completion.


####Creating display objects from data

It is also possible to create a display object for every item in a collection, using
the item to initialize the object.

    treeBuilder. uses (rootView). containing.

	    a (Sprite). forEveryItemIn (["Spades", "Hearts", "Diamonds", "Clubs"]).
		    withTheProperty ("name"). setToThe. item

    end.finish();

The collection can be an `Array`, a `Vector`, an `IIterable` or an `IIterator` (the last two from the
[AS3Commons Collections library](http://www.as3commons.org/as3-commons-collections/index.html "AS3Commons Collections"))


