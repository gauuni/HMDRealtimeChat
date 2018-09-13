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

typealias UserResultHandler = (GenericObjectResponse<UserResponse>?) -> ()
typealias ListUsersResultHandler = (GenericArrayObjectResponse<UserResponse>?) -> ()
typealias GenericResultHandler = (GenericResponse<Any>?) -> ()

class RootAPI: NSObject {

    static let rootURL = "http://192.168.1.15:5000/"
    static var auth: String { return rootURL + "api/auth/" }
    static var conversation: String { return rootURL + "api/conversation/" }
    static var register: String { return auth + "register" }
    static var login: String { return auth + "login" }
    static var users : String { return conversation + "users"}
    static var channel : String { return conversation + "channels"}
    static var publish : String { return conversation + "publish"}
    static var join : String { return conversation + "join"}
    
    @discardableResult static func signIn(email: String, password: String, resultHandler: UserResultHandler?) -> DataRequest?{
        let params = ["email": email,
                      "password": password]
        
        return Alamofire.request(login, method: .post, parameters: params)
            .responseObject { (response: DataResponse<GenericObjectResponse<UserResponse>>) in
                resultHandler?(response.value)
        }
    }
    
    @discardableResult static func join(userId: String, channelId: String, resultHandler: GenericResultHandler?) -> DataRequest?{
        let params = ["userId": userId,
                      "channelId": channelId]
        
        return Alamofire.request(join, method: .post, parameters: params)
            .responseObject { (response: DataResponse<GenericResponse<Any>>) in
                resultHandler?(response.value)
        }
    }
    
    @discardableResult static func fetchOnlineUsers(resultHandler: ListUsersResultHandler?) -> DataRequest?{
        return Alamofire.request(users)
            .responseObject { (response: DataResponse<GenericArrayObjectResponse<UserResponse>>) in
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
                      "content": message]
        
        return Alamofire.request(publish, method: .post, parameters: params)
            .responseObject { (response: DataResponse<GenericResponse<Any>>) in
                resultHandler?(response.value)
        }
    }
}
