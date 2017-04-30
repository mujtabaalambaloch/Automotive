//
//  FavouriteVC.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit

class FavouriteVC: UIViewController {
    @IBOutlet weak var favTableView: UITableView!

    static let cellIdentifier = "FavCellIdentifer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteVC.cellIdentifier)
        favTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteVC.cellIdentifier, for: indexPath) as! FavTableViewCell
        return cell
    }
}
