# Automotive

**Note: This only runs on iOS 10+ Device**

To run simple open the **Automotive.xcworkspace**

From Xcode: Connect Device, Product > Run

This displays a list of Automotives with the following: Model (Make), Year, Price, Mileage, Fuel Type and if it Accident Free. 

Its features are:

- ```favourites``` - Favourites cars can be added or removed, they are cached in CoreData for offline mode. The Tab Bar indicates the number of favourite car. Note this is disabled for Accident cars
- ```map``` - Displaying the Map of location using the address 
- ```scroll images``` - Displaying and scroll images of the Cars

This project contains the following librabies

1. [Alamofire](https://github.com/Alamofire/Alamofire) - To call the Flickr API and have a response in JSON
2. [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - To map the JSON response into Model Classes
3. [AlamofireImage](https://github.com/Alamofire/AlamofireImage) - To download images and cache them
4. [ImageSlideView](https://github.com/zvonicek/ImageSlideshow) - Loading Images and Slide them in a ScrollView
