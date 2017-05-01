//
//  CarTableViewCell.swift
//  Automotive
//
//  Created by Mac on 4/30/17.
//  Copyright © 2017 Mujtaba Alam. All rights reserved.
//

import UIKit
import ImageSlideshow

class CarTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageSlideView: ImageSlideshow!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var mapAddressButton: UIButton!
    @IBOutlet weak var favSwitch: UISwitch!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var accidentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.addShadow()
    }
}


