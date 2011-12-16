

#Display Tree Builder

A simple Domain Specific Language to set up display trees. 

###Example

    var displayTreeBuilder:DisplayTreeBuilder = new DisplayTreeBuilder();
    displayTreeBuilder.startWith(_contextView).begin
    	//Adds a Sprite with name "Menu", containing one
    	//instance of each FullScreenButton and EditButton
    	.add(Sprite).withName("Menu").begin
    		.add(FullScreenButton)
    		.add(EditButton)
    	.end
    	//Adds 3 instance of container, each with
    	//a single instance of Content
    	.times(3).add(Container).begin
    		.add(Content)
    	.end
    .end.finish();
    
The DSL only allows terms where they make sense (e.g. you can not place
`withName` after `times(x)`). This is especially useful in IDEs with 
code completion.