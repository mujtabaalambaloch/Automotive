//
//  Formatter.swift
//  Automotive
//
//  Created by Mac on 5/1/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation

class Formatter {

    class func milageValue(milage: Int) -> String {
        return "\(milage.formattedWithSeparator) km"
    }
    
    class func priceValue(price: Int) -> String {
        return "€\(price.formattedWithSeparator)"
    }
    
    class func fuelValue(fuel: String) -> String {
        return "Fuel Type: \(fuel)"
    }
    
    class func yearValue(year: String) -> String {
        return "Year: \(year)"
    }

}
