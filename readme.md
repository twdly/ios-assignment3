# iOS Assignment 3

A tea timer made by Delbert, Griffin, Kevin and Tai

GitHub repository available [here](https://github.com/twdly/ios-assignment3)

## Features

### Timers - Tai
- Start timers for the set length of the selected tea to ensure your tea is never left steeping for too long
- View all currently running timers in the list view
- Receive a notification whenever a timer is finished 

### Randomiser - Kevin
- To help decision paralysis, the app can select random teas 
- Filter the teas based on your preferences using the randomiser view
- After randomly selecting a tea, you can navigate directly to the page for the chosen tea to start a timer

### Add, update and delete teas - Delbert
- Add teas to your collection by pressing the plus button on the tea list view
- Delete old or unwanted teas using a convenient swipe action in the list view
- Edit existing teas by clicking the edit button in the toolbar on an individual tea view

### Tea stock - Griffin
- Manage your teas by keeping track of the amount you likely have available
- Automatically reduce the amount of tea you have when starting a timer
- A list of teas you are running low on can be viewed in the stock tab to remind you what teas you might want to restock

### Reviews - Tai
- Write reviews for your favourite teas to share them with other users
- Read reviews from other users to find other teas you may want to try
- Reviews are stored on an [azure web service](https://teareview-fuaygvbagwfegda8.australiaeast-01.azurewebsites.net/) written with ASP.NET
    - Code for the web server can be found [here](https://github.com/twdly/tea-reviews)
    - Note that reviews are stored in memory and are cleared out periodically
