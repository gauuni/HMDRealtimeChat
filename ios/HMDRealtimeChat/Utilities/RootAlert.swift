//
//  FitnessMessage.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/3/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RootAlert: NSObject {
    var yesAction : UIAlertAction!
    
    static let sharedInstance = RootAlert()
    
    override init() {
        super.init()
    }
    
    /** Show alert with title, message and type of alert
     **/
    func showMessage(title: String, message: String, okButton: String = "OK", cancelButton: String = "Cancel", preferredStyle: UIAlertControllerStyle = .alert, viewCtrl: UIViewController?, success: ((Bool, String) -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancelAction = UIAlertAction(title: cancelButton, style: .cancel) { (action) in success?(false, "Cancel")}
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: okButton, style: .default) { (action) in
            success?(true, okButton)
        }
        alertController.addAction(OKAction)
        
        if viewCtrl != nil {
            viewCtrl!.present(alertController, animated: true, completion: nil)
        }
        else {
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true) { }
        }
    }
    
    func showInfo(message: String, action: String = "OK", preferredStyle: UIAlertControllerStyle = .alert, title: String? = "Dility Player", fromController: UIViewController? = nil, success: ((Bool, String) -> Void)?){
       
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: preferredStyle)
        
        let OKAction = UIAlertAction(title: action, style: .default) { (a) in
            success?(true, action)
        }
        alertController.addAction(OKAction)
     
        (fromController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true, completion: nil)
    }
    
    func showInfoSheetForDisconnect(message: String = RootString.Settings.alertLogout, action: String = "Disconnect", preferredStyle: UIAlertControllerStyle = .actionSheet, title: String? = "Dility Player", fromController: UIViewController? = nil, success: ((Bool, String) -> Void)?){
        
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: preferredStyle)
        
        let OKAction = UIAlertAction(title: action, style: .default) { (a) in
            success?(true, action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: nil)
        alertController.addAction(OKAction)
        alertController.addAction(cancel)
        (fromController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirm(title: String? = RootString.AlertMessages.chooseOption, message: String, preferredStyle: UIAlertControllerStyle = .alert, from viewController: UIViewController? = nil, success: ((Bool) -> Void)?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
            success?(false)
        }
        alertController.addAction(noAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            success?(true)
        }
        alertController.addAction(yesAction)
        
        (viewController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true)
    }
    
    /*
     Alert thêm mới folder
     */
    func showFormAddFolder(title: String? = nil, message: String=RootString.AlertMessages.requiredName, text: String? = nil, okTitle: String="Create", preferredStyle: UIAlertControllerStyle = .alert, from viewController: UIViewController? = nil, success: ((Bool, String?) -> Void)?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.title = title
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),NSAttributedStringKey.foregroundColor : UIColor.red]), forKey: "attributedMessage")
        
        let noAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
            self.yesAction = nil
            success?(false, nil)
        }
        
        alertController.addAction(noAction)
        
        alertController.addTextField { (textField: UITextField) in
            
            textField.text = text
            textField.placeholder = RootString.Playlist.enterPlaylistName
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            
        }
        
        yesAction = UIAlertAction(title: okTitle, style: .default) { (action) in
            
            self.yesAction = nil
            
            let data: String = alertController.textFields![0].text!
            if data.length != 0 {
                //add cell into section 2
                success?(true, data)
            }
            
        }
        
        alertController.addAction(yesAction)
        yesAction.isEnabled = false
        DispatchQueue.main.async {
            (viewController ?? UIApplication.shared.keyWindow?.rootViewController!)?.present(alertController, animated: true)
            //self.present(alertController, animated: true)
        }
        
    }
    
    /*
     Alert rename song
     */
    func showFormRename(title: String? = nil, message: String?="Rename", name: String? = nil, artist: String?=nil, success: ((Bool, String?, String?) -> Void)?){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let message = message{
            let attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(key: .font, value: UIFont.systemFont(ofSize: 13), at: message)
            attributedString.addAttribute(key: .foregroundColor, value: UIColor.red, at: message)
            alertController.setValue(attributedString, forKey: "attributedMessage")
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            self.yesAction = nil
            success?(false, nil, nil)
        }
        
        alertController.addAction(cancelAction)
        
        alertController.addTextField { (textField: UITextField) in
            
            textField.text = name
            textField.placeholder = "Enter title."
            textField.addTarget(self, action: #selector(self.alertTextFieldDidChange(_:)), for: .editingChanged)
            
        }
        
        alertController.addTextField { (textField: UITextField) in
            
            textField.text = artist
            textField.placeholder = "Enter artist."
            
        }
        
        yesAction = UIAlertAction(title: "Update", style: .default) { (action) in
            let songName = alertController.textFields![0].text!
            let songArtist = alertController.textFields![1].text!
            
            self.yesAction = nil

            success?(true, songName, songArtist)
            
        }
        
        alertController.addAction(yesAction)
        
        if name == nil{
            yesAction.isEnabled = false
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
            //self.present(alertController, animated: true)
        }
        
    }
    
    
    @objc func alertTextFieldDidChange(_ sender:UITextField) {
        let data: String = sender.text!
        if data.trim.length != 0 {
            yesAction.isEnabled = true
        }
        else {
            yesAction.isEnabled = false
        }
    }
}
