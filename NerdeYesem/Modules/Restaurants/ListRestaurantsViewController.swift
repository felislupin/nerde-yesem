//
//  ListRestaurantsViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit
import CoreLocation

class ListRestaurantsViewController: NerdeYesemBaseViewController {
    
    //UI Components
    @IBOutlet weak var listRestaurantTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    // variables
    private let refreshControl = UIRefreshControl()
    private let listRestaurantsTableViewCellHeight: CGFloat = 150.0
    private var restaurantDataSet: [RestaurantModel] = [] {
        didSet {
            self.listRestaurantTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.initManager()
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //listen location
        NotificationCenter.default.addObserver(self, selector: #selector(locationFetched(_:)), name: .locationUpdated, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager.shared.startListener()

    }
    
    //MARK:- UI functions
    fileprivate func setUI() {
        setTableView()
        self.noDataLabel.isHidden = false
    }
    
    fileprivate func setTableView() {
        listRestaurantTableView.delegate = self
        listRestaurantTableView.dataSource = self
        listRestaurantTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        listRestaurantTableView.register(UINib(nibName: "ListRestaurantsTableViewCell", bundle: .main), forCellReuseIdentifier: "ListRestaurantsTableViewCell")
        listRestaurantTableView.tableFooterView = UIView()
    }
    
    //Mark Data fetcher funcs
    fileprivate func setData(lat: Double, long: Double) {
        ZomatoAPIEndpointCaller.shared.fetchNeariestRestaurants(lat: lat , long: long, onSuccess: { (response) in
            DispatchQueue.main.async {
                if response.restaurants.count > 0 {
                    self.noDataLabel.isHidden = true
                    self.refreshControl.endRefreshing()
                    self.restaurantDataSet = response.restaurants.map({
                        $0.restaurant
                    })
                    
                } else {
                    self.noDataLabel.isHidden = false
                    self.refreshControl.endRefreshing()
                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.showErrorPopup(message: "Restaurants didn't fetch!")
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc func refreshData() {
        LocationManager.shared.startListener()
    }
    
    
    //MARK:- Helpers
    @objc func locationFetched(_ sender: NSNotification?) {
        if let userInfo = sender?.userInfo as? [String: Any] {
            if let loc = userInfo["currentLocation"] as? CLLocation {
                let lat = loc.coordinate.latitude
                let long = loc.coordinate.longitude
                LocationManager.shared.stopListener()
                self.setData(lat: lat, long: long)
            }
        }
    }
    
    func goRestaurantDetailView(model: RestaurantModel) {
            let detailVC = UIStoryboard(name: "Restaurants", bundle: Bundle.main).instantiateViewController(withIdentifier: "RestaurantDetailViewController") as! RestaurantDetailViewController
            detailVC.restaurant = model
            self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK:- tableView functions
extension ListRestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantDataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListRestaurantsTableViewCell", for: indexPath) as? ListRestaurantsTableViewCell {
            cell.setCell(model: restaurantDataSet[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        goRestaurantDetailView(model: self.restaurantDataSet[index])
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listRestaurantsTableViewCellHeight
    }
    
    
}
