//
//  Vehicle.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation
import SwiftyJSON

class Vehicle {
    
    var id : Int?
    var firstRegistration : String?
    var accidentFree : Bool?
    var images : [JSON]?
    var powerKW : Int?
    var address : String?
    var price : Int?
    var mileage : Int?
    var make : String?
    var fuelType : String?
    
    init(json:JSON) {
        self.id = json["ID"].int
        self.firstRegistration = json["FirstRegistration"].string
        self.accidentFree = json["AccidentFree"].bool
        self.images = json["Images"].arrayValue
        self.powerKW = json["PowerKW"].int
        self.address = json["Address"].string
        self.price = json["Price"].int
        self.mileage = json["Mileage"].int
        self.make = json["Make"].string
        self.fuelType = json["FuelType"].string
    }
    
}
