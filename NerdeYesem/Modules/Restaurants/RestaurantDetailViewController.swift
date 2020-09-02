//
//  RestaurantDetailViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 1.09.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit
import Kingfisher

class RestaurantDetailViewController: NerdeYesemBaseViewController {

    @IBOutlet weak var onlineDeliveryLabel: UILabel!
    @IBOutlet weak var timingLLabel: UILabel!
    @IBOutlet weak var cuisinesLabel: UILabel!
    @IBOutlet weak var localityVerboseLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    

    //Varaiabless
    var restaurant: RestaurantModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

    }
    
    //MARK:- UI functions
    
    fileprivate func setUI() {
        if let model = self.restaurant {
            self.cuisinesLabel.text = model.cuisines
            self.restaurantName.text = model.name
            self.localityVerboseLabel.text = model.location.locality_verbose
            if model.featured_image != "" {
                backgroundImageView.kf.setImage(with: URL(string:  model.featured_image))
            }
            self.adressLabel.text = model.location.address
            if model.has_online_delivery == 0 {
                self.onlineDeliveryLabel.text = "not exist"
            } else {
                self.onlineDeliveryLabel.text = "exist"
            }
            self.timingLLabel.text = model.timings
        }
    }
    

}
