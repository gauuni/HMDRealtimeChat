//
//  FitnessType.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/10/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import CoreLocation

typealias Sohdatring = String

struct Address {
    var addID: Int?
    var option: String=""
    var name_this_place: String=""
    var building_name: String=""
    var number_house: String=""
    var street_address: String=""
    var city: String=""
    var state: String=""
    var postcode: String=""
}

struct ProductAddCart {
    var productID: Int
    var quanlity: Int
}

struct ProductAddCartPacking {
    var productID: Int
    var quanlity: Int
    var packagingId: Int
}

// using to sending to Braintree
struct SohdaCard {
    var number: String
    var expirationMonth: String
    var expirationYear: String
    var cvv: String
    var name: String
}

struct SohdaCartContactInfo {
    var addressId: Int
    var phone: String
    var name: String
    var valid_years_old: String
}

struct SohdaSavedCard {
    var cardType: String
    var maskedNumber: String
    var last4: String
    var email: String? // using for delete Paypal. Can be nullable if cardtype is for Card
    var billingAgreementId: String? // using for delete Paypal if cardtype is for Card
}

struct SohdaSavedPaypal {
    var email: String
    var billingAgreementId: String
}
