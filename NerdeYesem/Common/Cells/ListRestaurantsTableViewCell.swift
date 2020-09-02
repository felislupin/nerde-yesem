//
//  ListRestaurantsTableViewCell.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit
import Kingfisher

class ListRestaurantsTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cuisinesLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    @IBOutlet weak var restaurantsVoteLabel: UILabel!
    @IBOutlet weak var localityVerboseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setCell(model: RestaurantModel) {
        self.cuisinesLabel.text = model.cuisines
        self.restaurantNameLabel.text = model.name
        self.localityVerboseLabel.text = model.location.locality_verbose
        self.restaurantsVoteLabel.text = "Restaurant voted \(model.user_rating.votes) times"
        if model.featured_image != "" {
            backgroundImage.kf.setImage(with: URL(string:  model.featured_image))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
