//
//  FavViewModel.swift
//  Automotive
//
//  Created by Mac on 5/1/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation

class FavViewModel {
    
    private var vehicle: Favourites
    
    var makeText: String {
        return vehicle.make!
    }
    
    var mileageText: String {
        return "\(vehicle.mileage.formattedWithSeparator) km"
    }
    
    var addressText: String {
        return vehicle.address!
    }
    
    var yearText: String {
        return "Year: \(vehicle.firstRegistration!)"
    }
    
    var fuelText: String {
        return "Fuel Type: \(vehicle.fuelType!)"
    }
    
    var priceText: String {
        return "€\(vehicle.price.formattedWithSeparator)"
    }
    
//    var photos: Array<Any>? {
//        var photosArray = [AlamofireSource]();
//        for name in vehicle.images! {
//            photosArray.append(AlamofireSource.init(urlString: name.string!)!)
//        }
//        return photosArray
//    }
    
    init(vehicle: Favourites) {
        self.vehicle = vehicle
    }
}
