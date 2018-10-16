//
//  SohdaPrerences.swift
//  Sohda
//
//  Created by Duc Nguyen on 5/18/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

final class RootPrefrences {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = RootPrefrences()
    
    // MARK: Local Variable
    
}

extension RootPrefrences {
    
}

extension RootPrefrences {
    
}

extension DefaultsKeys {
    static let regionCode = DefaultsKey<String>("regionCode")

}

