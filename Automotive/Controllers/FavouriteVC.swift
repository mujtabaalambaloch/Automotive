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
    
    var messageLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteVC.cellIdentifier)
        favTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.emptyTable()
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
            
            if searchResult.count > 0 {
                messageLabel?.isHidden = true
            } else {
                messageLabel?.isHidden = false
            }
            
            self.favTableView.reloadData()
            
        } catch {
            print("Error")
        }
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
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteVehicle(index: indexPath.row)
            // delete item at indexPath
        }
        
        return [delete]
    }
    
    // MARK: Perform Segue for Map Address
    
    func deleteFavourites(sender:AnyObject) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Delete Favourite", message: "Are you sure you want to delete this from Favourites?", preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
            let deleteButton = sender as! UIButton
            self.deleteVehicle(index: deleteButton.tag)
        }
        
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(okAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func deleteVehicle(index: Int) {
        let viewModel: FavViewModel = self.vehicles[index]
        viewModel.deleteFavourite()
        self.vehicles.remove(at: index)
        
        if self.vehicles.count == 0 {
            self.messageLabel?.isHidden = false
        } else {
            self.messageLabel?.isHidden = true
        }
        
        self.favTableView.reloadData()
    }
    
    // MARK: Perform Segue for Map Address
    
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
    
    // MARK: Empty Table
    
    func emptyTable() {
        messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        messageLabel?.textColor = UIColor.lightGray
        messageLabel?.numberOfLines = 0
        messageLabel?.textAlignment = .center
        messageLabel?.font = UIFont.systemFont(ofSize: 18)
        messageLabel?.sizeToFit()
        messageLabel?.isHidden = false
        messageLabel?.text = "You don't have any favorites yet. All your favorites will show up here."
        self.favTableView.backgroundView = messageLabel
    }
}

