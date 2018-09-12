//
//  Validator.swift
//  Fitness
//
//  Created by Thinh Truong on 11/8/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation

class RootValidator {
    
    static func isEmail(email: String) -> Bool{
        
        do {
            let regex = try NSRegularExpression(pattern: "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+", options: .caseInsensitive)
            
            return regex.matches(in: email, options: .reportProgress, range: NSMakeRange(0, email.count)).count > 0
            
        } catch {}
        
        return false
        
    }
    
    static func formatCreditCardNumber(cardNumber: String?, separator: String = " ") -> String?{
        
        guard let cardNumber = cardNumber else {
            return nil
        }
        
        var result = cardNumber.replacingOccurrences(of: separator, with: "")
        
        let separatorCount = (result.count - 1) / 4
        
        for i in 0...separatorCount {
            
            let index = result.index(result.startIndex, offsetBy: i * 4 + i)
            
            result.insert(contentsOf: separator, at: index)
            
        }
        
        return result
    }
}
