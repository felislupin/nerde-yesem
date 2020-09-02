//
//  LoginViewController.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 1.09.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        authenticateUser()
    }
    
    func goHomeView() {
            let homeVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let navController = UINavigationController(rootViewController: homeVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
    }
    
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.goHomeView()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
