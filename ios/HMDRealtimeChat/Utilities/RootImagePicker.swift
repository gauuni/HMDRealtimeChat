//
//  RootImagePicker.swift
//  Sohda
//
//  Created by Duc Nguyen on 8/4/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Photos

protocol RootImagePickerDelegate {
    func imagePickerControllerDidCancel(_ picker: RootImagePicker)
    func magePickerController(_ picker: RootImagePicker, image: UIImage)
}

class RootImagePicker: NSObject {
    
    let viewController =  UIApplication.shared.keyWindow?.rootViewController
    var imagePicker = UIImagePickerController()
    var delegate: RootImagePickerDelegate?
    
    override init() {
        
        
    }
    
    func openImagePicker() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
                self.setupCamera()
            } else {
                self.alertPromptToAllowCameraAccessViaSetting()
            }
        }
    }
    
    func setupCamera() {
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            viewController?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: "Error", message: "This app does not have access to your camera or video. You can enable access in Privacy Settings.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alert) -> Void in
            self.delegate?.imagePickerControllerDidCancel(self)
            self.imagePicker.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            self.delegate?.imagePickerControllerDidCancel(self)
            self.imagePicker.dismiss(animated: true, completion: nil)
        })
         viewController?.present(alert, animated: true)
    }
    
    func openGallary()
    {
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.setupPhotoAcess()
                } else {
                    self.alertPromptToAllowCameraAccessViaSetting()
                }
            })
        } else  if photos == .denied {
             self.alertPromptToAllowCameraAccessViaSetting()
        } else if photos == .authorized {
            self.setupPhotoAcess()
        }
        
    }
    
    func setupPhotoAcess(){
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        self.viewController?.present(self.imagePicker, animated: true, completion: nil)
    }
    
}

extension RootImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.imagePickerControllerDidCancel(self)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.delegate?.magePickerController(self, image: pickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
