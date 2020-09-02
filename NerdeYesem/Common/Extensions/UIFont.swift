//
//  UIFont.swift
//  NerdeYesem
//
//  Created by Rapsodo-Mobil-1 on 31.08.2020.
//  Copyright © 2020 Hayri Oguz. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum Montserrat: String {
        
        case bold = "Montserrat-Bold"
        case thin = "Montserrat-Thin"
        case light = "Montserrat-Light"
        case black = "Montserrat-Black"
        case medium = "Montserrat-Medium"
        case italic = "Montserrat-Italic"
        case regular = "Montserrat-Regular"
        case semibold = "Montserrat-SemiBold"
        case extrabold = "Montserrat-ExtraBold"
        
        case boldItalic = "Montserrat-BoldItalic"
        case thinItalic = "Montserrat-ThinItalic"
        case lightItalic = "Montserrat-LightItalic"
        case mediumItalic = "Montserrat-MediumItalic"
        case semiboldItalic = "Montserrat-SemiBoldItalic"
        case extraboldItalic = "Montserrat-ExtraBoldItalic"
    }
    
    // Default font size
    static let defaultSize: CGFloat = 12.0

    static let defaultFont: UIFont = {
        let systemFont = UIFont.systemFont(ofSize: defaultSize)
        return systemFont
    }()


    static func montserrat(size: CGFloat, type: UIFont.Montserrat) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            NSLog("Unsupported font <%@>", type.rawValue)
            return defaultFont
        }
        
        return font
    }

}

