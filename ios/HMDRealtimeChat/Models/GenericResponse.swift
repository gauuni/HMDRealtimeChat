//
//  GenericResponse.swift
//  Fitness
//
//  Created by Thinh Truong on 10/25/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

import UIKit

class BaseResponse: Mappable {
    
    var status: Bool?
    var message: String?
    var isMore: Bool?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status  <- map["status"]
        message <- map["message"]
    }
}

class GenericResponse<T>: BaseResponse{
    
    var data: T?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        data    <- map["data"]

    }
    
}

class GenericArrayResponse<T>: BaseResponse{
    
    var data: [T]?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        data    <- map["data"]
        
    }
    
}

class GenericObjectResponse<T: Mappable>: BaseResponse {
    
    var data: T?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        data    <- map["data"]
    }
    
}

class GenericArrayObjectResponse<T: Mappable>: BaseResponse {
    
    var data: [T]?
    
    override func mapping(map: Map) {
        
        super.mapping(map: map)
        
        data    <- map["data"]
    }
    
}




