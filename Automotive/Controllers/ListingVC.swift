//
//  ListingVC.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit
import ImageSlideshow

class ListingVC: UIViewController {

    @IBOutlet weak var carsTableView: UITableView!
    
    static let cellIdentifier = "CarCellIdentifier"
    
    let activityIndicator = UIActivityIndicatorView()
    
    var vehicles = [VehicleViewModel]()
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carsTableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: ListingVC.cellIdentifier)
        carsTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        carsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadCars), for: .valueChanged)
        
        loadCars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carsTableView.reloadData()
    }
    
    // MARK: - API Request
    
    func loadCars() {

        if refreshControl.isEnabled {
            carsTableView.isUserInteractionEnabled = false
        }
        
        Helpers.showActivityIndicator(activityIndicator,self.view)
        
        APIManager.shared.getAllCars { (json) in
            Helpers.hideActivityIndicator(self.activityIndicator)
            
            self.carsTableView.isUserInteractionEnabled = true
            
            if self.refreshControl.isEnabled {
                self.refreshControl.endRefreshing()
            }
            
            if !(json.null != nil) {
                
                self.vehicles = []
                
                if let listRes = json["vehicles"].array {
                    for item in listRes {
                        let vehicle = Vehicle(json: item)
                        let viewModel = VehicleViewModel.init(vehicle: vehicle)
                        self.vehicles.append(viewModel)
                    }
                    
                    self.carsTableView.reloadData()
                }
            }
        }
    }
    
}

// MARK: - Table View Methods

extension ListingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 378.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: ListingVC.cellIdentifier, for: indexPath) as! CarTableViewCell
        
        let viewModel: VehicleViewModel = vehicles[indexPath.row]
        
        cell.modelLabel.text = viewModel.makeText
        cell.mileageLabel.text = viewModel.mileageText
        cell.addressLabel.text = viewModel.addressText
        cell.yearLabel.text = viewModel.yearText
        cell.fuelTypeLabel.text = viewModel.fuelText
        cell.priceLabel.text = viewModel.priceText
        
        cell.imageSlideView.setImageInputs(viewModel.photos as! [InputSource])
        
        cell.favSwitch.isOn = viewModel.isFav
        cell.favSwitch.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
        cell.favSwitch.tag = indexPath.row
        
        if !viewModel.accidentFree {
            cell.favSwitch.isEnabled = false
            cell.accidentImageView.isHidden = false
            cell.mainView.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
        } else {
            cell.favSwitch.isEnabled = true
            cell.accidentImageView.isHidden = true
            cell.mainView.backgroundColor = UIColor.white
        }
        
        cell.mapAddressButton.addTarget(self, action: #selector(displayMapAddress(sender:)), for: .touchUpInside)
        cell.mapAddressButton.tag = indexPath.row
        
        return cell
    }
    
    // MARK: - Favourite Functionality
    
    func switchValueDidChange(sender:AnyObject) {
        let favSwitch = sender as! UISwitch
        let viewModel: VehicleViewModel = vehicles[favSwitch.tag]
        viewModel.addRemoveFav()
        
        if DatabaseHandler.totalFav() > 0 {
            self.tabBarController?.tabBar.items?.last?.badgeValue = String(DatabaseHandler.totalFav())
        } else {
            self.tabBarController?.tabBar.items?.last?.badgeValue = nil
        }
    }
    
    // MARK: - Display Map Address
    
    func displayMapAddress(sender:AnyObject) {
        let mapButton = sender as! UIButton
        performSegue(withIdentifier: "AddressSegue", sender: mapButton.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = (sender as! Int)
        let viewModel: VehicleViewModel = vehicles[row]
        
        if segue.identifier == "AddressSegue" {
            
            let nav = segue.destination as! UINavigationController
            let details = nav.topViewController as! MapAddressVC
            details.address = viewModel.addressText
            
        }
    }
    
}
