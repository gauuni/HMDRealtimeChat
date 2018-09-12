//
//  RootAPI.swift
//  HMDRealtimeChat
//
//  Created by Khoi Nguyen on 9/12/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class RootAPI: NSObject {

    static let rootURL = "http://192.168.1.15:5000/"
    static var conversation: String { return rootURL + "api/conversation/" }
    static var users : String { return conversation + "users"}
    static var channel : String { return conversation + "channel"}
    static var publish : String { return conversation + "publish"}
    
    @discardableResult static func fetchOnlineUsers(resultHandler: ((GenericArrayResponse<String>?) -> ())?) -> DataRequest?{
        return Alamofire.request(users)
            .responseObject { (response: DataResponse<GenericArrayResponse<String>>) in
                resultHandler?(response.value)
        }
    }
    
    @discardableResult static func createChannel(senderId: String, receiverId: String, resultHandler: ((GenericResponse<String>?) -> ())?) -> DataRequest?{
        let params = ["sender": senderId,
                      "receiver": receiverId]
        
        return Alamofire.request(channel, method: .post, parameters: params)
            .responseObject { (response: DataResponse<GenericResponse<String>>) in
                resultHandler?(response.value)
        }
    }
    
    @discardableResult static func publish(channelId: String, senderId: String, receiverId: String, message: String, resultHandler: ((GenericResponse<Any>?) -> ())?) -> DataRequest?{
        let params = ["channelId": channelId,
                      "sender": senderId,
                      "receiver": receiverId,
                      "message": message]
        
        return Alamofire.request(publish, method: .post, parameters: params)
            .responseObject { (response: DataResponse<GenericResponse<Any>>) in
                resultHandler?(response.value)
        }
    }
}
