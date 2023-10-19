//
//  PaypalRequisites.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.03.2021.
//

import Foundation

/**
 Data model, for PayPal method
 */
public struct PaypalRequisites {
    /**
     Email for PayPal account
     */
    public let email: String

    /**
     Initializer for model
     */
    public init(email: String) {
        self.email = email
    }
}
