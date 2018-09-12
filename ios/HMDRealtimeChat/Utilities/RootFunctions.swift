//
//  Functions.swift
//  Fitness
//
//  Created by Thinh Truong on 10/24/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation

let DEVELOPMENT = true
let TAG = "Sohda"

func performAfterDelay(delay: TimeInterval, caller: @escaping () -> ()){
    
    let dispatchTime = DispatchTime.now() + delay
    
    DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
        
        OperationQueue.main.addOperation(caller)
        
    })
    
}

func Log(items: Any...){
   /*
    if !DEVELOPMENT {
        return
    }
    print(TAG, items)
    */
}
