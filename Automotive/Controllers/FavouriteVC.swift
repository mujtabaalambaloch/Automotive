//
//  FavouriteVC.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit
import CoreData

class FavouriteVC: UIViewController {
    @IBOutlet weak var favTableView: UITableView!

    static let cellIdentifier = "FavCellIdentifer"
    
    var vehicles = [FavViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteVC.cellIdentifier)
        favTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let fetchRequest:NSFetchRequest<Favourites> = Favourites.fetchRequest()
        
        do {
            let searchResult = try DatabaseHandler.getContext().fetch(fetchRequest)
            print("number of results: \(searchResult.count)")
            
            for result in searchResult as [Favourites] {
                let viewModel = FavViewModel.init(vehicle: result)
                self.vehicles.append(viewModel)
            }
            
        } catch {
            print("Error")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteVC.cellIdentifier, for: indexPath) as! FavTableViewCell
        
        let viewModel: FavViewModel = vehicles[indexPath.row]
        
        cell.modelLabel.text = viewModel.makeText
        cell.milageLabel.text = viewModel.mileageText
        cell.fuelTypeLabel.text = viewModel.fuelText
        cell.priceLabel.text = viewModel.priceText
        cell.mapAddressButton.setTitle(viewModel.addressText, for: UIControlState.normal)
        cell.yearLabel.text = viewModel.yearText
        
        return cell
    }
}
