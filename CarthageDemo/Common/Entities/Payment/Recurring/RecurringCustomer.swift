//
//  RecurringCustomer.swift
//  UnlimintSDK-Core
//
//  Created by Mohammad Parvez on 09/10/23.
//

import Foundation


import Foundation

/**
 Customer data model
 */
public struct RecurringCustomer: Codable {
    private enum CodingKeys: String, CodingKey {
        case email
        case locale
        //case ipAddress = "ip"
        case customerID = "id"
    }

    /**
     Customer’s e-mail address
     Optional for wallets where setting in PM "May omit customer email" is enabled
     */
    public let email: String

    /**
     Preferred locale for the payment page (ISO 639-1 language code).
     The default locale (en or other locale if it's set as default in Merchant account) will be applied if the selected locale (received in request) is not supported.
     Supported locales are: ar, az, bg, cs, de, el, en, es, fr, hu, hy, id, it, ja, ka, ko, ms, nl, pl, pt, ro, ru, sr, sv, th, tr, uk, vi, zh
     */
    public let locale: String?

    //public let ipAddress: String?
    public let customerID: String?
    /**
     Initializer
     */
    public init(
                email: String,
                locale: String?,
                customerID: String?) {
        self.email = email
        self.locale = locale
        //self.ipAddress = ipAddress
        self.customerID = customerID
    }
}
