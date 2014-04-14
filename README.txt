nr2483

============================================================================================
					Quick Info
============================================================================================


My App does the following:

Phase 1 (implemented as part of Homework 1)

Functionality/Features:

	1) Simple and clean UI
	2) Displays Query results on the map as pins 
	3) Displays details such as rating if available as subtitles for the pins
	4) Displays appropriate error messages 
	5) Easy to use customized UISlider element to provide search results within a particular radius. 
This has been added on the results page itself where the map is displayed so that the user can adjust radius and see results on the same screen rather than switching between screens

Phase 2 (implemented as part of Homework 3)

	1) Tab Bar Controller enables easy navigation back and forth between Search Screen,Results screen and Favorites screen
	2) The user is provided names of locations matching the query in tabular form along with an “Add to Favorites” button (conventional star icon) which can be used to add or remove locations from the favorites tab
	3) The user can click on any of the results. When the user selects a result,the app extracts from the results dictionary important details such as price level,rating,vicinity, related images for the searched location and displays it to the user in another view
	4) The app uses core data to save details of favorites and displays the saved information in the Favorites tab. The user can use the swipe to delete gesture in iOS to remove a particular entry from the Favorites list.


============================================================================================
					File Highlights (most of the code is here)
============================================================================================

ListViewController.m
This contains the code to save context to Core Data Model,


FavoritesTableViewController.m
This contains the code for the fetch request to extract the save data and populate table.


============================================================================================
					Known Bugs
============================================================================================
While I have fixed some bugs during testing, there are currently no bugs that I am aware of. 
I am currently working on additional features such as making the cells in Favorites Tab clickable to 
display details from there. But I wasn’t able to implement these by the deadline.
Currently the app just displays names of the locations marked as Favorites

============================================================================================
	     				Lessons Learned
============================================================================================
1) Even when the query framework was provided to us,a lot of thought needs to go into  app development and design. It is a very open ended problem and there is always scope for improvement.

2) Not to panic when you see that your app is crashing all of a sudden even though the code was working fine a minute ago! After spending hours on stack overflow I learnt that SIGABRT exceptions are not something to be afraid of and can be caused by something as simple as a reference on the storyboard to a method which has been deleted. I picked up some useful debugging skills 

3) iOS development is fun but not as easy as it looks on the outside, there are several subtleties to be picked up which will take some time, but this homework definitely has given me a good start in this direction.

============================================================================================
					References
============================================================================================

This project involved searching extensively on the internet to understand the design of apps using Core Data and Tab bar controllers
 
http://www.appcoda.com/introduction-to-core-data/
http://www.appcoda.com/core-data-tutorial-update-delete/


Deleting a specific entry:
http://stackoverflow.com/questions/6524876/removing-a-specific-entry-row-from-core-data

SetPredicate- for Unique id in database
Pass id atIndexPath

I have discussed the implementation details for Core Data with Shrutika Dasgupta and Yash Parikh. (students taking this course)

