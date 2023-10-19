//
//  PaymentMethodData.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 09.10.2020.
//

import Foundation

/**
 Data model
 */
public struct PaymentMethodData: Codable {

    /**
     Data model
     */
    public struct CardAccount: Codable {
        private enum CodingKeys: String, CodingKey {
            case billingAddress = "billing_address"
        }

        /**
         Billing Address
         */
        public let billingAddress: BillingAddress?

        /**
         Initializer for model
         */
        public init(token: String?,
                    billingAddress: BillingAddress?) {
            self.billingAddress = billingAddress
        }
    }

    /**
     The name of the merchant
     */
    public let merchantName: String

    /**
     Payment method type name
     */
    public let paymentMethod: String

    /**
     Customer data
     */
    public let customer: PaymentCustomer

    /**
     Merchant order data
     */
    public let merchantOrder: PaymentMerchantOrder

    /**
     Payment data
     */
    public let paymentData: PaymentData

    /**
     Card account data
     */
    public let cardAccount: CardAccount?

    /**
     Initializer for model
     */
    public init(with merchantName: String,
                paymentMethod: String,
                customer: PaymentCustomer,
                merchantOrder: PaymentMerchantOrder,
                paymentData: PaymentData,
                cardAccount: CardAccount?) {
        self.merchantName = merchantName
        self.paymentMethod = paymentMethod
        self.customer = customer
        self.merchantOrder = merchantOrder
        self.paymentData = paymentData
        self.cardAccount = cardAccount
    }
}
