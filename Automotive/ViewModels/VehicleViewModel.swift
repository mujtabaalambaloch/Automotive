//
//  VechicleViewModel.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation
import ImageSlideshow
import CoreData

class VehicleViewModel {
    
    private var vehicle: Vehicle
    
    var makeText: String {
        return vehicle.make!
    }
    
    var mileageText: String {
        return Formatter.milageValue(milage: vehicle.mileage!)
    }
    
    var addressText: String {
        return vehicle.address!
    }
    
    var yearText: String {
        return Formatter.yearValue(year: vehicle.firstRegistration!)
    }
    
    var fuelText: String {
        return Formatter.fuelValue(fuel: vehicle.fuelType!)
    }
    
    var priceText: String {
        return Formatter.priceValue(price: vehicle.price!)
    }
    
    var photos: Array<Any>? {
        var photosArray = [AlamofireSource]();
        for name in vehicle.images! {
            photosArray.append(AlamofireSource.init(urlString: name.string!)!)
        }
        return photosArray
    }
    
    var isFav: Bool {
        return DatabaseHandler.favExist(favID: vehicle.id!)
    }
    
    func addRemoveFav() {
    
        if !isFav {
            let favourite = NSEntityDescription.insertNewObject(forEntityName: String(describing: Favourites.self), into: DatabaseHandler.getContext()) as! Favourites
            favourite.id = Int64(vehicle.id!)
            favourite.accidentFree = vehicle.accidentFree!
            favourite.address = vehicle.address
            favourite.firstRegistration = vehicle.firstRegistration
            favourite.fuelType = vehicle.fuelType
            favourite.mileage = Int64(vehicle.mileage!)
            favourite.price = Int64(vehicle.price!)
            favourite.powerKW = Int64(vehicle.powerKW!)
            favourite.make = vehicle.make
            
            DatabaseHandler.saveContext()
        } else {
            DatabaseHandler.deleteContext(favID: vehicle.id!)
        }
    }
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}


