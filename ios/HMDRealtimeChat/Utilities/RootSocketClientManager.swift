//
//  RootSocketClientManager.swift
//  HMDRealtimeChat
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit
import SocketIO
import NotificationBannerSwift

typealias VoidBlock = () -> ()

class RootSocketClientManager: NSObject {

    struct SocketEvents {
        static let online = "online"
        static let offline = "offline"
        static let channelGenerated = "channelGenerated"
    }
    private static let socketURL = "http://192.168.1.15:5000"
    private let manager = SocketManager(socketURL: URL(string: RootSocketClientManager.socketURL)!,
                                config: [.log(false),
                                         .compress,
                                         .forceNew(true)])
    var socket: SocketIOClient!
    var banner: StatusBarNotificationBanner?
    
    static let shared = RootSocketClientManager()
    
    override init() {
        
        socket = manager.defaultSocket
        
        
    }
    
    public func connect(completionHandler: VoidBlock?){
        
        socket.on(clientEvent: .connect) {data, ack in
            
            self.socket.emit(RootSocketClientManager.SocketEvents.online, with: [RootAuthManager.shared.id])
            completionHandler?()
        }
        
        socket.on(clientEvent: .error) { (data, ack) in
            completionHandler?()
        }
        
        socket.on(clientEvent: .disconnect) { (data, ack) in

            completionHandler?()
        }
        
        socket.connect()
        
    }
    
    func showBanner(title: String, style: BannerStyle){
        if banner != nil{
            banner?.dismiss()
            banner = nil
        }
        banner = StatusBarNotificationBanner(title: title, style: style)
        banner?.show()
        
    }
    
    public func disconnect(){
        
//        self.socket.emit(RootSocketClientManager.SocketEvents.offline, with: [RootAuthManager.shared.id])
        
        RootAuthManager.shared.id = ""
        RootAuthManager.shared.name = ""
        
        socket.removeAllHandlers()
        socket.disconnect()
    }
    
    public func emit(topic: String, content: [Any]){
        socket.emit(topic, with: content)
    }
    
    public func send(channelId: String, content: [Any]){
        self.emit(topic: channelId, content: content)
    }
    
    public func on(event: String, completHandler: (([Any])->())?){
        socket.on(event) { (data, ack) in
            completHandler?(data)
        }
    }
}
