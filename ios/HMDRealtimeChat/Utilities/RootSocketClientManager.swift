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
                                         .compress ])
    var socket: SocketIOClient!
    
    static let shared = RootSocketClientManager()
    
    override init() {
        
        socket = manager.defaultSocket
        
        
    }
    
    public func connect(completionHandler: VoidBlock?){
        
        socket.on(clientEvent: .connect) {data, ack in
            
            self.socket.emit(RootSocketClientManager.SocketEvents.online, with: [RootAuthManager.sharedInstance.username])
            completionHandler?()
        }
        
        socket.on(clientEvent: .error) { (data, ack) in
            completionHandler?()
        }
        
        socket.on(clientEvent: .disconnect) { (data, ack) in
            completionHandler?()
        }
        
        socket.on(RootSocketClientManager.SocketEvents.channelGenerated) { (data, ack) in
            guard let stringArr = data as? [String] else { return }
            let sender = stringArr[0]
            let receiver = stringArr[1]
            let channelId = stringArr[2]
            
            RootAlert.sharedInstance.showConfirm(title: nil, message: sender + " has sent you a message") { (isAccept) in
                if isAccept{
                    let vc = RootLinker.getViewController(storyboard: .Main, aClass: ChatViewController.self) as! ChatViewController
                    vc.receiver = receiver
                    vc.channelId = channelId
                    RootLinker.sharedInstance.rootViewDeckController?.centerViewController = vc
                }
            }
        }
        
        socket.connect()
        
    }
    
    func showBanner(title: String, style: BannerStyle){
        let banner = StatusBarNotificationBanner(title: title, style: style)
        banner.show()
    }
    
    public func disconnect(){
        
        self.socket.emit(RootSocketClientManager.SocketEvents.offline, with: [RootAuthManager.sharedInstance.username])
        
        RootAuthManager.sharedInstance.username = ""
        
        socket.removeAllHandlers()
        socket.disconnect()
    }
    
    public func emit(topic: String, content: [Any]){
        socket.emit(topic, with: content)
    }
    
    public func send(channelId: String, content: [Any]){
        self.emit(topic: channelId, content: content)
    }
}
