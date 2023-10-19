//
//  CheckCardAccount.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 28.09.2020.
//

import Foundation

/**
 Check card account data model
 */
public struct CheckCardAccount: Codable {

    /**
     Address for billing
     */
    public let billingAddress: BillingAddress?

    /**
     Initializer
     */
    public init(billingAddress: BillingAddress?) {
        self.billingAddress = billingAddress
    }
}
