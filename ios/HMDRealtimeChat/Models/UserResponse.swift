//
//  UserResponse.swift
//  HMDRealtimeChat
//
//  Created by Khoi Nguyen on 9/13/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit
import ObjectMapper

class UserResponse: Mappable {
    var id = ""
    var name = ""
    var email = ""
    var password = ""
    var channels = [ChannelResponse]()
    var numberOfMessages = 0
    var channelId = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["_id"]
        name        <- map["name"]
        email       <- map["email"]
        password    <- map["password"]
    }
}

class ChannelResponse: Mappable {
    var id = ""
    var name = ""
    var image = ""
    var users = [UserResponse]()
    var messages = [MessageResponse]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["_id"]
        name        <- map["name"]
        image       <- map["image"]
        users    <- map["users"]
        messages    <- map["messages"]
    }
}

class MessageResponse: Mappable {
    var id = ""
    var senderId = ""
    var receiverId = ""
    var channelId = ""
    var content = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["_id"]
        senderId        <- map["senderId"]
        receiverId       <- map["receiverId"]
        channelId    <- map["channelId"]
        content    <- map["content"]
    }
}



