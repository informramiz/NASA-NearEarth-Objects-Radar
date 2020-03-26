# NASA-NeoWs
A simple app that uses [NASA Open APIs for Near Earth Objects](https://api.nasa.gov/) to show the upcoming asteriods for the next days that will pass by earth. NASA NeoWs (Near Earth Object Web Service) is a RESTful web service for near earth Asteroid information. With NeoWs a user can: search for Asteroids based on their closest approach date to Earth, lookup a specific Asteroid with its NASA JPL small body id, as well as browse the overall data-set.

The app allows a user to

1. View the asteriods for the next 7 days that will be closest to earth
2. Search an asteriod detail by its NEO reference ID. For example `54016331, 54016340, 3582516` are some valid reference IDs for asteriods.
3. User can save asteriods by marking them favorite. These favorites are saved in Core Data making them available even when app is offline.


![demo-gif](demo/neo-2.gif)
