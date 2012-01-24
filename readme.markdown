

#Display Tree Builder

A simple Domain Specific Language to set up display trees. 

###Example

    var displayTree:DisplayTree = new DisplayTree();
    displayTree. hasA (_contextView). containing.

    	//Adds a Sprite with name "Menu", containing one
    	//instance of each FullScreenButton and EditButton
    	a (Sprite). withName ("Menu"). containing.
    		a (FullScreenButton).
    		an (EditButton).
    	end.

    	//Adds 3 instance of container, each with
    	//a single instance of Content
    	times (3). a (Container). containing.
    		a (Content).
    	end.
    end.finish();
    
The DSL only allows terms where they make sense (e.g. you can not place
`withName` after `times(x)`). This is especially useful in IDEs with 
code completion.