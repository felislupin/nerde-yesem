//
//  ListRestaurantsViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit
import CoreLocation

class ListRestaurantsViewController: UIViewController {
    
    //UI Components
    @IBOutlet weak var listRestaurantTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.initManager()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(locationFetched(_:)), name: .locationUpdated, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager.shared.startListener()

    }
    
    @objc func locationFetched(_ sender: NSNotification?) {
        if let userInfo = sender?.userInfo as? [String: Any] {
            if let loc = userInfo["currentLocation"] as? CLLocation {
                let lat = loc.coordinate.latitude
                let long = loc.coordinate.longitude
                LocationManager.shared.stopListener()
                ZomatoAPIEndpointCaller.shared.fetchNeariestRestaurants(lat: lat , long: long, onSuccess: { (response) in
                    print(response)
                    
                }) { (error) in
                    print(error)
                }
            }
        }

    }
}
