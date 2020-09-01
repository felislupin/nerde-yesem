//
//  HomeViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit


class HomeViewController: TabsViewController {
    
    
    let listRestaurantsVC = UIStoryboard(name: "Restaurants", bundle: Bundle.main).instantiateViewController(withIdentifier: "ListRestaurantsViewController") as! ListRestaurantsViewController
    
    let favoriteRestaurantsVC = UIStoryboard(name: "Restaurants", bundle: Bundle.main).instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
       
        title = "NERDE YESEM"
        setPages()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollToIndex(index: lastScrolledPageIndex, animated: false)
    }

    func setPages() {
        tabLabelWidth = 80.0

        pages.append(PageModel(name: NSLocalizedString("Near", comment: ""), label: nil, vc: listRestaurantsVC))
        pages.append(PageModel(name: NSLocalizedString("Favs", comment: ""), label: nil, vc: favoriteRestaurantsVC))
    }
    
    override func tabChanged(index: Int) {
       
    }
}
