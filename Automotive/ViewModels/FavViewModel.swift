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
        return Formatter.milageValue(milage: Int(vehicle.mileage))
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
        return Formatter.priceValue(price: Int(vehicle.price))
    }
    
    var photoURL: URL? {
        return URL.init(string: vehicle.images!)
    }
    
    func deleteFavourite() {
        DatabaseHandler.deleteContext(favID: Int(vehicle.id))
    }
    
    init(vehicle: Favourites) {
        self.vehicle = vehicle
    }
    
    
}
