//
//  NSNotificationName+Additions.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import Foundation


extension NSNotification.Name {
    static let locationUpdated: NSNotification.Name = {
            return NSNotification.Name("CurrentLocationUpdated")
    }()
}
