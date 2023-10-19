//
//  PaymentTokenMethodData.swift
//  Swinject
//
//  Created by Denis Gnezdilov on 28.11.2020.
//

import Foundation

/**
 Data model
 */
public struct PaymentTokenMethodData: Codable {

    /**
     Data model
     */
    public struct CardAccount: Codable {
        private enum CodingKeys: String, CodingKey {
            case token
            case pan
            case billingAddress = "billing_address"
            case cardIssuer
        }

        /**
         Card token value, used instead of card information, except card.security_code (it's mandatory)
         */
        public let token: String

        /**
         The last 4 digits of the card number
         */
        public let pan: String

        /**
         Billing Address
         */
        public let billingAddress: BillingAddress?

        
        public let cardIssuer: String?

        /**
         Initializer for model
         */
        public init(token: String,
                    pan: String,
                    billingAddress: BillingAddress?,
                    cardIssuer: String?) {
            self.token = token
            self.pan = pan
            self.billingAddress = billingAddress
            self.cardIssuer = cardIssuer
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
    public let cardAccount: CardAccount

    /**
     Initializer for model
     */
    public init(with merchantName: String,
                paymentMethod: String,
                customer: PaymentCustomer,
                merchantOrder: PaymentMerchantOrder,
                paymentData: PaymentData,
                cardAccount: CardAccount) {
        self.merchantName = merchantName
        self.paymentMethod = paymentMethod
        self.customer = customer
        self.merchantOrder = merchantOrder
        self.paymentData = paymentData
        self.cardAccount = cardAccount
    }
}
