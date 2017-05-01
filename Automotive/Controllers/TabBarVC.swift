//
//  TabBarVC.swift
//  Automotive
//
//  Created by Mac on 5/1/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayBadge(showBadge: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate Method
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 {
            displayBadge(showBadge: false)
        } else {
            displayBadge(showBadge: true)
        }
    }
    
    // MARK: - Display Favourites Badge
    func displayBadge(showBadge: Bool) {
        if showBadge && DatabaseHandler.totalFav() > 0 {
            self.tabBar.items?.last?.badgeValue = String(DatabaseHandler.totalFav())
        } else {
            self.tabBar.items?.last?.badgeValue = nil
        }
    }
}
