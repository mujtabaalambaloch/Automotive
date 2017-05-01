//
//  Helper.swift
//  Automotive
//
//  Created by Mac on 4/30/17
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import Foundation
import UIKit

class Helpers {

    // Helper method to show activity indicator
    static func showActivityIndicator(_ activityIndicator: UIActivityIndicatorView, _ view: UIView) {
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.color = UIColor.lightGray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // Helper method to hide activity indicator
    static func hideActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }

}
