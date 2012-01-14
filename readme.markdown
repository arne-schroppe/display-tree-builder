#Display Tree Builder

A simple Domain Specific Language to set up trees of display objects. 

###Example

    var displayTreeBuilder:DisplayTreeBuilder = new DisplayTreeBuilder();
    displayTreeBuilder.startWith(_contextView).begin
    	//Adds a Sprite with the name "Menu", containing one
    	//instance of each FullScreenButton and EditButton
    	.add(Sprite).withName("Menu").begin
    		.add(FullScreenButton)
    		.add(EditButton)
    	.end
    	//Adds three instances of Container, each with a single 
    	//instance of Content as their child element
    	.times(3).add(Container).begin
    		.add(Content)
    	.end
    .end.finish();
    
The DSL only allows terms where they make sense (e.g. you can not place
`withName` after `times(x)`). This is especially useful in IDEs with 
code completion.