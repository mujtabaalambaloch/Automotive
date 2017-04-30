//
//  APIManager.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation

class APIManager {

    static let shared = APIManager()
    let baseURL = NSURL(string: BASE_URL)
    
    // MARK: - Request Server
    //Request Server function
    func requestServer(_ method: HTTPMethod,_ path:String,_ params:[String:Any]?,_ encoding:ParameterEncoding,_ completionHandler: @escaping(JSON) -> Void) {
        
        let url = baseURL?.appendingPathComponent(path)
        
        Alamofire.request(url!, method: method, parameters: params, encoding: encoding, headers: nil).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    let jsonData = JSON(value)
                    completionHandler(jsonData)
                    break
                    
                case .failure:
                    completionHandler(nil)
                    break
                }
            }
    }
    
    //API Getting all cars list
    func getAllCars(completionHandler: @escaping(JSON) -> Void) {
        requestServer(.get, ALL, nil, URLEncoding(), completionHandler)
    }
    
}
