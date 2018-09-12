//
//  UIFont+MonserratSystemFont.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

let kFontMontserratBold = "Montserrat-Bold"
let kFontMontserratRegular = "Montserrat-Regular"
let kFontAvenirNextMedium = "AvenirNext-Medium"
let kFontAvenirNextUltraLight = "AvenirNext-UltraLight"
let kFontSFTextSemibold = "SFUIText-Semibold"
let kFontLatoRegular = "Lato-Regular"
let kFontRobotoRegular = "Roboto"

/*
UIFontWeightUltraLight
UIFontWeightThin
UIFontWeightLight
UIFontWeightRegular
UIFontWeightMedium
UIFontWeightSemibold
UIFontWeightBold
UIFontWeightHeavy
UIFontWeightBlack
*/

extension UIFont {
    class func appFont(name: String, fontSize: CGFloat) -> UIFont {
        return UIFont(name: name, size: fontSize)!
    }
    
    class func appFont(ofSize: CGFloat, weight: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight(rawValue: weight))
    }
}
