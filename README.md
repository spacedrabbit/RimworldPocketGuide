# RimworldPocketGuide
At-A-Glance Reference for Ludeon Studio's Indie Hit, "Rimworld"

### Current Concerns:
The variance and complexity of these XML's isn't making for a very scalable solution to indexing everything...

Additionally, considering that the structure of the XML's themselves change frequently, this static code will need  constant revising. 

Lastly, not only is the structure of the XML changing but the keys are as well. Unless it is at least possible to verify the core keys for each "ThingDef", I don't currently see a way to build this database and also maintain it on future releases. Which makes this a fruitless endevour considering the speed of Ludeon's patch and release frequency.

### Search Functionalty
In its current state, a very basic search implementation is able to filter out biomes based on their `label` property

Ideally, and eventually, all properties would be searchable with different weights.. meaning searching "desert" would yield results of the biomes labeled `<name>Desert` but also animals who's biome is in an `Arid_Biomes`. The later would be displayed after the first due to a different weighting of the search terms. In this abstracted example, it would be easy to add a search weight of `1.0` to objects who's `label` has the search term and a weight of, say, `0.8` if their `habitats` property (or whichever property). Then results would be displayed in order of weighted ranking. 

What I'm not yet certain about is how "fuzzy" matching can be implemented. I'm going out on a speculative limb when I assume there is a library that can take care of this, as fuzzy pattern matching is difficult and not likely something I can devote time to for this project. 

The next step after fuzzy search would be to update the live results in the table view in a manner similar to autocompletion in Xcode. Again, this stage is very vague and speculative at the moment. 

### Other Concerns
Everything is very much hard coded in a sense... I have to know ahead of time all of the xml files to be used, their class hierarchies, and their individual properties. Not only that, I have to filter out "client side" and "backend" properties manually.. for example an abstract XML class is of no importance to a user, but may ultimately affect how search results are parsed, and how objects are linked in the database. 

Speaking of database, I can only begin to start adding in Realm once I'm aware of my models (see above for discussion on that..). 

In short: there's too much, non-uniformed data to parse. and no obvious way (to me) to create a robust enough method to parse everything out while preserving sibiling relationships, class heirarchy, and relavent model properties.

Takeaways:
1. SWXMLHash has been a fairly useful library to use once its conventions are semi-understood (wtf is the difference between a component and element?? it's never explained). Unfortunately, the libaries reliance on generics is a blessing and a curse: some things can be done invisibly (like proper type casting after parsing), but in that simplicity it obfuscates what is actually being returned from it's function calls (ok is this now an `XMLIndex` or `[XMLIndex]` or ... should this model conform to `XMLIndexDeserializable` or `XMLElementDeserializable`...)
  I'll likely use this library again now that I'm used to it, but it does leave things to be desired. But I think this might just be a result of the use of XML to store data in general. I'm not terribly interested in creating a custom XML parser either. 

2. Implementing a live search functionality is pretty simple. I'm impressed with the strides Apple took to make this a feature available to apps

3. I still want to implement Realm. It's so cool. 

