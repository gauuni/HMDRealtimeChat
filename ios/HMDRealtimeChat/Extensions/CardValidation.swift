//
//  CardValidation.swift
//  Sohda
//
//  Created by Khoi Nguyen on 7/1/17.
//  Copyright © 2017 Sohda. All rights reserved.
//

import UIKit

typealias CardInfo = (type: CardType, formatted: String, valid: Bool)

enum CardType: String {
    case Unknown, Amex="American Express", Visa="Visa", MasterCard="MasterCard", Diners="Diners Club", Discover="Discover", JCB="JCB", Elo, Hipercard, UnionPay, Maestro
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay, Maestro]
    
    var regex : String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .UnionPay:
            return "^(62|88)[0-9]{5,}$"
        case .Hipercard:
            return "^(606282|3841)[0-9]{5,}$"
        case .Elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        case .Maestro:
            return "^(5018|5020|5038|6304|6759|676[1-3])"
        default:
            return ""
        }
    }
    
    var image: UIImage{
        switch self {
        case .Amex:
            return #imageLiteral(resourceName: "img_Card_AMEX")
        case .Visa:
            return #imageLiteral(resourceName: "img_Card_VISA")
        case .MasterCard:
            return #imageLiteral(resourceName: "img_Card_MasterCard")
        case .Diners:
            return #imageLiteral(resourceName: "img_Card_Dinners")
        case .Discover:
            return #imageLiteral(resourceName: "img_Card_Dicover")
        case .JCB:
            return #imageLiteral(resourceName: "img_Card_JCB")
        case .UnionPay:
            return #imageLiteral(resourceName: "img_Card_Union")
        case .Hipercard:
            return #imageLiteral(resourceName: "img_Card_HiperCard")
        case .Elo:
            return #imageLiteral(resourceName: "img_Card_Elo")
        case .Maestro:
            return #imageLiteral(resourceName: "img_Card_Maestro")

        default:
            return #imageLiteral(resourceName: "debit_wallet")
        }
    }

}

class CardValidation: NSObject {

    static var shared = CardValidation()
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        
        
        for tuple in digitStrings.enumerated() {
            guard let digit = Int(tuple.element) else { return false }
            let odd = tuple.offset % 2 == 1
            
            switch (odd, digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
    
    func checkCardNumber(input: String) -> CardInfo {
        // Get only numbers from the input string
        
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
        
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false
        
        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }
        
        // check validity
        valid = luhnCheck(number: numberOnly)
        
        // format
        var formatted4 = ""
        for character in numberOnly {
            if formatted4.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        
        formatted += formatted4 // the rest
        
        // return the tuple
        return CardInfo(type, formatted, valid)
    }
}
