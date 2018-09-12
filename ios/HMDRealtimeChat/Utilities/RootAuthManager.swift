//
//  AppDelegate.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import ObjectMapper
import CloudStorageWorker
import GoogleSignIn
import GoogleAPIClientForREST
import BoxContentSDK


class RootAuthManager: NSObject {
    
    static let sharedInstance = RootAuthManager()
    
    lazy var userDefaults = UserDefaults.standard
    let keychainWrapper = KeychainWrapper.standard
    
    let driveWorker = DriveWorker.init(clientID: "563885904867-ap3tbmhiut0u0t1tt21eto3jlp2nvo73.apps.googleusercontent.com")
    let dropboxWorker = DropboxWorker.init(withAppKey: "851a9x74s602hrz")
    let oneDriveWorker = OneDriveWorker.init(appID: "000000004817FD12", scopes: [.readwrite, .offlineAccess])
    let boxDriveWorker = BoxWorker.init(clientID: "6fmxqztd1owgzp4ams7wezggf7gj7976", clientSecret: "8racExViWQK9vF2v8QDA20IxYoJjyuZ8", redirectURIString: "boxsdk-6fmxqztd1owgzp4ams7wezggf7gj7976://boxsdkoauth2redirect")
    
    override init() {
        super.init()
        
        driveWorker.addScope(scopes: [kGTLRAuthScopeDrive])
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain(){
            driveWorker.signInSilently(completion: nil)
        }
        
    }
    
    
    

    

    
}
