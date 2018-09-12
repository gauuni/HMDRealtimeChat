//
//  AppDelegate.swift
//  StyleManager
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit

class RootStyleManager {
    static let sharedInstance = RootStyleManager()
    
    func setupAppearance() {
        setupNav()
        setupBarButtonItem()
        setupTabbarItem()
        setLightStatusBar()
        setupOrther()
    }
    
    func setupNav() {
        
        UINavigationBar.appearance().barStyle = UIBarStyle.default
        
        UINavigationBar.appearance().backgroundColor = UIColor.white
         UINavigationBar.appearance().isTranslucent =  false
         UINavigationBar.appearance().tintColor = UIColor.colorWithHexString(hex: "4A4A4A")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.appFont(ofSize: 17.0, weight: UIFont.Weight.bold.rawValue),
            NSAttributedStringKey.foregroundColor: UIColor.colorWithHexString(hex: "4A4A4A")
        ]
    }
    
    func setLightStatusBar() {
        UIApplication.shared.statusBarStyle = .default
    }
    
    func setupBarButtonItem() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font:UIFont.appFont(ofSize: 17.0, weight: UIFont.Weight.bold.rawValue)], for: .normal)
    }
    
    func setupTabbarItem() {
       UITabBar.appearance().backgroundColor = UIColor.white
    }
    

    func setupOrther() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).leftViewMode = .never
    }

}
