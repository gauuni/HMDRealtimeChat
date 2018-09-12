//
//  FitnessNotification.swift
//  Fitness
//
//  Created by Duc Nguyen on 11/11/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let PlayerViewWillAppear = Notification.Name("PlayerViewWillAppear")
    static let PlayerViewDidAppear = Notification.Name("PlayerViewDidAppear")
    static let AdViewDidReceiveAd = Notification.Name("AdViewDidReceiveAd")
    
    
    static let PlaylistDetailReloadData = Notification.Name("PlaylistDetailReloadData")
    static let PopUpDismiss = Notification.Name("PopUpDismiss")
    static let SongFetchAllAudioFilesFirst = Notification.Name("SongFetchAllAudioFilesFirst")
    static let UpdateDowloadingProgress = Notification.Name("UpdateDowloadingProgress")
    static let DeleteDowloadProgress = Notification.Name("DeleteDowloadProgress")
    static let DeleteAllDownloadProgress = Notification.Name("DeleteAllDownloadProgress")
    static let RemoveDownloadFailProgress = Notification.Name("RemoveDownloadFailProgress")
    
    
    //state change is play
    static let PlayerDidChangeStatus = Notification.Name("PlayerDidChangeStatus")
    
    // reload transfrer
    static let ReloadTransfer = Notification.Name("ReloadTransfer")
}
