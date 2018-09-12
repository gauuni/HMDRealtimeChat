//
//  AppDelegate.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

class RootColor {
    var hex : String {
        didSet {
            update()
        }
    }
    
    private(set) var color : UIColor
    
    init(hex : String){
        self.hex = hex
        self.color = UIColor.colorWithHexString(hex: hex)
    }
    
    private func update() {
        self.color = UIColor.colorWithHexString(hex: hex)
    }
    
    func redComponent() -> CGFloat {
        return UIColor.redComponentFromHexString(hex: self.hex)
    }
    
    func greenComponent() -> CGFloat {
        return UIColor.greenComponentFromHexString(hex: self.hex)
    }
    
    func blueComponent() -> CGFloat {
        return UIColor.blueComponentFromHexString(hex: self.hex)
    }
    
    func alphaComponent() -> CGFloat {
        return UIColor.alphaComponentFromHexString(hex: self.hex)
    }
    
    func colorWithAdjustedBrightness(byPercent percent: CGFloat) -> RootColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newColor = UIColor(hue: hue, saturation: saturation, brightness: brightness * (1+percent), alpha: alpha)
            
            if let hex = UIColor.hexStringFromColor(color: newColor) {
                return RootColor(hex: hex)
            }
        }
        return self
    }
}
