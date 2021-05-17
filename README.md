# MovieApp

# IMPORTANT
‼️ Normally, `Configuration.plist` should not be included in the repository.

## Architecture
I’ve decided to use an MVC architecture because firstly I’m a big fan of it and for me, it is not architectural design but more likely an architectural philosophy. Btw. addChild is available from iOS 5 :) 
It’s all about composition, reusability, and separation of concerns.


### MVC Components
* Model - business logic
* View - xib or in code
* Controller - passing actions from view to model
* Services - it is an additional layer, you can think about it as everything external (system, network, etc)


### Business Components
* Container 
	* compose search & list
	* passing values from search to list
* Search 
	* handling search events
	* calling search API
* List
	* displaying & refreshing list
* Cell
	* displaying cell
	* fetching poster image

