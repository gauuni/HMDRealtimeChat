//
//  RealmResultsExtension.swift
//  BangB2
//
//  Created by ducnguyen on 11/17/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import HMDMusicManager

extension Results{
    
    func get <T:Object> (offset: Int, limit: Int ) -> Array<T>{
        //create variables
        var lim = 0 // how much to take
        var off = 0 // start from
        var l: Array<T> = Array<T>() // results list
        
        //check indexes
        if off<=offset && offset<self.count - 1 {
            off = offset
        }
        if limit > self.count {
            lim = self.count
        }else{
            lim = limit
        }
        
        //do slicing
        for i in off..<lim {
            let dog = self[i] as! T
            l.append(dog)
        }
        
        //results
        return l
    }
    
    func getRandom <T:Object> (limit: UInt32 ) -> Array<T>{
        var uniqueNumbers = Set<T>()
        while uniqueNumbers.count < limit {
            //random trong tổng số lấy ra limit
            let index = Int(arc4random_uniform(UInt32(self.count)))
            let dog = self[index] as! T
            uniqueNumbers.insert(dog)
        }
        return Array(uniqueNumbers).shuffled()
    }
    
    func sortAToZ() -> Results<PlaylistItemObject>{
        return self.sorted(byKeyPath: "title", ascending: true) as! Results<PlaylistItemObject>
        
    }
    
    func sortZToA() -> Results<PlaylistItemObject>{
        return self.sorted(byKeyPath: "title", ascending: false) as! Results<PlaylistItemObject>
    }
    
}

