//
//  FavouriteVC.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

class FavouriteVC: UIViewController {
    @IBOutlet weak var favTableView: UITableView!

    static let cellIdentifier = "FavCellIdentifer"
    
    var vehicles = [FavViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteVC.cellIdentifier)
        favTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest:NSFetchRequest<Favourites> = Favourites.fetchRequest()
        
        self.vehicles = []
        
        do {
            let searchResult = try DatabaseHandler.getContext().fetch(fetchRequest)
            for result in searchResult as [Favourites] {
                let viewModel = FavViewModel.init(vehicle: result)
                self.vehicles.append(viewModel)
            }
            
            self.favTableView.reloadData()
            
        } catch {
            self.favTableView.reloadData()
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
        cell.addressLabel.text = viewModel.addressText
        cell.yearLabel.text = viewModel.yearText
        
        cell.deleteButton.addTarget(self, action: #selector(deleteFavourites(sender:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        
        cell.carImageView.af_setImage(withURL: viewModel.photoURL!)
        
        cell.mapAddressButton.addTarget(self, action: #selector(displayMapAddress(sender:)), for: .touchUpInside)
        cell.mapAddressButton.tag = indexPath.row
        
        return cell
    }
    
    func deleteFavourites(sender:AnyObject) {
        let deleteButton = sender as! UIButton
        let viewModel: FavViewModel = vehicles[deleteButton.tag]
        viewModel.deleteFavourite()
        self.favTableView.reloadData()
    }
    
    
    func displayMapAddress(sender:AnyObject) {
        let mapButton = sender as! UIButton
        performSegue(withIdentifier: "MapAddressSegue", sender: mapButton.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = (sender as! Int)
        let viewModel: FavViewModel = vehicles[row]
        
        if segue.identifier == "MapAddressSegue" {
            
            let nav = segue.destination as! UINavigationController
            let details = nav.topViewController as! MapAddressVC
            details.address = viewModel.addressText
            
        }
    }
    
}

