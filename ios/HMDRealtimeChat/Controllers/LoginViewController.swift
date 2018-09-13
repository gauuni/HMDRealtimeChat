//
//  LoginViewController.swift
//  HMDRealtimeChat
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit

class LoginViewController: RootViewController {

    @IBOutlet private weak var txtEmail: UITextField!
    @IBOutlet private weak var txtPassword: UITextField!
    
    @IBAction func loginPressed(){
        self.showLoading()
        
        RootAPI.signIn(email: txtEmail.text!, password: txtPassword.text!) { (response) in
            guard let user = response?.data else { return }
            RootAuthManager.shared.id = user.id
            RootAuthManager.shared.name = user.name
            
            self.hideLoading()
            
            RootSocketClientManager.shared.connect() {
                
                RootLinker.sharedInstance.rootViewDeckController?.centerViewController = RootLinker.getViewController(storyboard: .Main, aClass: RootNavigationUser.self)
                
            }
        }
        
        
    }

}
