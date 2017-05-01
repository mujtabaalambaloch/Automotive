//
//  MapAddressVC.swift
//  Automotive
//
//  Created by Mac on 5/1/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapAddressVC: UIViewController {

    @IBOutlet weak var addressMapView: MKMapView!
    
    var address:String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddressPin(address: address!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Done Action
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setAddressPin(address:String) {
        
        let gecoder = CLGeocoder()
        
        gecoder.geocodeAddressString(address) { (placemarks, error) in
            
            if error != nil {
                print("Error \(error?.localizedDescription)")
            }
            
            if let placemark = placemarks?.first {
                
                let coordinate: CLLocationCoordinate2D = placemark.location!.coordinate
                
                let region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.01))
                
                self.addressMapView.setRegion(region, animated: true)
                
                //Create a pin
                let dropPin = MKPointAnnotation()
                dropPin.coordinate = coordinate
                dropPin.title = address
                
                self.addressMapView.addAnnotation(dropPin)
                self.addressMapView.selectAnnotation(self.addressMapView.annotations[0], animated: true)
            }
        }
    }
}
