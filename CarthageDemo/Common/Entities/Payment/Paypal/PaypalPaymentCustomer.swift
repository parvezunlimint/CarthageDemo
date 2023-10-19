//
//  PaypalPaymentCustomer.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.03.2021.
//

import Foundation

/**
 Data model
 */
public struct PaypalPaymentCustomer: Codable {
    private enum CodingKeys: String, CodingKey {
        case email
    }

    /**
     Customer’s e-mail address
     */
    public var email: String

    /**
     Initializer for model
     */
    public init(email: String) {
        self.email = email
    }
}
