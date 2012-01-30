
#Display Tree

A declarative language to set up trees of display objects.

###Example

    var displayTree:DisplayTree = new DisplayTree();
    
    displayTree. hasA(_contextView). containing.

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
