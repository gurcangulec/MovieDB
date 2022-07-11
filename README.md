# MovieDB App
#### Video Demo:  <URL HERE>
#### Description: 
This application uses the [Movie Database](https://www.themoviedb.org/) API to fetch data related to movies, actors, release dates, movie ratings etc. and uses that information to display movie and actor information pages. When the application is first opened it displays popular movie titles. You can scroll down and tap on any movie that interests you and it will display information related to that movie or you can use the search field on the top to search for any movie that exists on the Movie Database and see related information about the movie you searched for.

MovieDBApp.swift and ContentView.swift files are created automatically after creating an XCode project. The files named Movies, Cast, Actor, RelatedMovies, MovieListView, MovieView, MovieRow, ActorView, FetchData, and PosterImageStyle files are created by me. Let me quickly go over them and explain what they do.

Movies, Cast, Actor and RelatedMovies include my own data types. They were created with structs and I needed to carefully inspect the JSON that is returned to me by Movie DB API to write them. When written wrongly, the app doesn’t display information correctly or I cannot compile. Also in some of them I used computed properties like when I was trying to format the date value I am getting from the API.

FetchData file contains functions I wrote to fetch data from the API return it according to the datatype I choose. I wrote them static just to be able to use them directly. Plus they all use async and await since the application dependent on some server. Each function has a URL in them and then when they get a response functions put it in a data object and then I need to decode that data object to have the result. At the end I return the decoded data which is a JSON file.

Other files are creating the views that you see when you search for a movie and when the app is displaying movie and actor information. Starting with MovieRow. This file is creating each row on the app when the app is displaying movie titles as a list. Then I am passing this view to the MovieListView file. Task modifier in this file is used for calling downloadPopularMovies function and also after a search downloadMovies function is called. When any one of the movies is tapped on MovieView is called and it displays the information related to movies. Same as ActorView. All these views use similar things like VStacks, HStacks, Text, ScrollView, Dividers and Spacers to create the views.

Lastly I used some extensions while creating this applications like [KingFisher](https://github.com/onevcat/Kingfisher) to handle images and [CodableX](https://github.com/dscyrescotti/CodableX) for some property wrappers that Swift doesn’t offer as a default.
