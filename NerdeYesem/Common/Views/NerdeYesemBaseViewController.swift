//
//  NerdeYesemBaseViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 1.09.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit

class NerdeYesemBaseViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.backBarButtonItem?.setTitleTextAttributes([.font: UIFont(name: "Montserrat-Medium", size: 12.0)!], for: .normal)
            self.navigationItem.titleView = nil
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
        }
}

// MARK: - Popups
extension NerdeYesemBaseViewController {
    
   func showInfoPopup(message: String) {
        let alert = UIAlertController(title: NSLocalizedString("Info", comment: ""), message: message, preferredStyle: .alert)
        let done = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(done)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorPopup(message: String) {
         let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: message, preferredStyle: .alert)
         let done = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
         alert.addAction(done)
         self.present(alert, animated: true, completion: nil)
     }


    
}
