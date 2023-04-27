The Wire Simpsons/The Wire Character Viewer.

App Requirements
Your app should be written entirely in either Swift for iOS, or Kotlin for Android. Try to demonstrate your knowledge of both basic and advanced
language semantics. We are not yet using SwiftUI or Compose on our mobile projects, so please complete the exercise using UIKit for iOS or
XML layouts for Android.
Write a sample app that fetches and displays data from a RESTful Web API. The app should be comprised of two parts, a list and a detail. Your
app should support both portrait and landscape orientations on both phones and tablets.
On Phones, the list and detail should be separate screens, on Tablets, list and detail should appear on the same screen.
· For the list view, data should be displayed as a text only, vertically scrollable list of character names.
· The app should offer search functionality that filters the character list according to characters whose titles or descriptions contain the query
text
· Clicking on an item should load the detail view of that character, including the character’s image, title, and description. You choose the layout
of the detail.
· For the image in the detail view, use the URL in the "Icon" field of the API JSON response. For items with blank or missing image URLs, use
a placeholder image of your choice.
· Two variants of the app should be created, using a single shared codebase. Each variant should have a different name, package-name, and
url that it pulls data from. (We're interested in your methodology for creating multiple apps from a shared codebase)

Technical Instructions used to build out the APP. 

The Character Names was displayed in UITableView on the MainViewController.
SplitViewController was used to adhere to instructions for the iPad.
Shared Codebase was used to for both variants.
I implemented Dependency Injection.
Relied on MVVM pattern which will help make our code Testable. 

What was required? 

* A List and Detail.
* The list and detail display on iPhones must be separate, while the list and detail panels on iPad should be combined.
* Data should be shown in the list view as a vertically scrollable, text-only list of character names.
* The app should provide a search feature that restricts the character list to those whose names or descriptions match the search term.
* A character's image, title, and description should appear when clicking on an item to load the character's detail view.
* Use the URL in the "Icon" section of the API JSON response for the picture in the detail view. Use a placeholder picture for items whose image URLs are empty or missing.
* The program should be split into two different versions with a single shared source while working with Target Membership. 
* Each variation should have a unique name, package name, and url from which it obtains data.
* I omitted storyboard for better readability and clarity for the app. 
* MVVM Design Pattern
* Dependable NetworkLayer

Maintenance 

* Removed Uncessary Code by refactoring, Reorganizing Folders, and Reduce Clutter.

Overall this was a fun project to work on using UIKit. 

Feel free to ask any questions.




https://user-images.githubusercontent.com/80698243/234953124-faa0a38f-7066-4fa3-8e03-fa807bb9ed7c.mov



https://user-images.githubusercontent.com/80698243/234953738-5201c8ae-619f-4ad6-995d-905e5a32f196.mov

