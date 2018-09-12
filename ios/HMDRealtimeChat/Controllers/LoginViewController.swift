//
//  LoginViewController.swift
//  HMDRealtimeChat
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: RootViewController {

    @IBOutlet private weak var textfieldUsername: UITextField!
    
    @IBAction func loginPressed(){
        self.showLoading()
        
        RootAuthManager.sharedInstance.username = textfieldUsername.text!
        RootSocketClientManager.shared.connect() {
            self.hideLoading()
            
//            RootLinker.sharedInstance.rootViewDeckController?.leftViewController = RootLinker.getViewController(storyboard: .Main, aClass: RootNavigationUser.self)
            
            RootLinker.sharedInstance.rootViewDeckController?.centerViewController = RootLinker.getViewController(storyboard: .Main, aClass: RootNavigationUser.self)

        }
    }

}
