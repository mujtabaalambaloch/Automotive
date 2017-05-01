//
//  Favourites+CoreDataProperties.swift
//  Automotive
//
//  Created by Mac on 5/1/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation
import CoreData


extension Favourites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites");
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstRegistration: String?
    @NSManaged public var accidentFree: Bool
    @NSManaged public var powerKW: Int64
    @NSManaged public var address: String?
    @NSManaged public var price: Int64
    @NSManaged public var mileage: Int64
    @NSManaged public var make: String?
    @NSManaged public var fuelType: String?
    @NSManaged public var images: NSData?

}
