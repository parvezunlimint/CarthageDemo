//
//  PaymentMethodData.swift
//  UnlimintSDK
//
//  Created by Mohammad Parvez on 25-09-2023
//

import Foundation

/**
 Data model
 */
public struct RecurringPaymentMethodData: Codable {

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
    public let customer: RecurringCustomer

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

    public let recurringData: RecurringData

    /**
     Initializer for model
     */
    public init(with merchantName: String,
                paymentMethod: String,
                customer: RecurringCustomer,
                merchantOrder: PaymentMerchantOrder,
                paymentData: PaymentData,
                cardAccount: CardAccount?,
                recurringData: RecurringData) {
        self.merchantName = merchantName
        self.paymentMethod = paymentMethod
        self.customer = customer
        self.merchantOrder = merchantOrder
        self.paymentData = paymentData
        self.cardAccount = cardAccount
        self.recurringData = recurringData
    }
}


//public struct RecurringPaymentData: Codable {
//    private enum CodingKeys: String, CodingKey {
//        case amount
//        case currency
//        case note
//        case dynamicDescriptor = "dynamic_descriptor"
//        case transType = "trans_type"
//        case isGenerateToken = "generate_token"
//        case preauth
//    }
//    /**
//     The total transaction amount in selected currency with dot as a decimal separator, must be less than 100 millions
//     */
//    let amount: Decimal
//    /**
//     ISO 4217 currency code
//     */
//    let currency: String
//    /**
//     Note about the transaction that will not be displayed to customer
//     */
//    let note: String?
//    /**
//     Short description of the service or product, must be enabled by Unlimint manager to be used.
//     For Visa cards: maximum length 25 symbols, for MasterCard cards - 22 symbols.
//     */
//    let dynamicDescriptor: String?
//    /**
//     Identifies the type of transaction being authenticated.
//     
//     Values accepted:
//     - 01 - Goods/ Service Purchase
//     - 03 - Check Acceptance
//     - 10 - Account Funding • 11 = Quasi-Cash Transaction
//     - 28 - Prepaid Activation and Load Note: Values derived from the 8583 ISO Standard.
//     */
//    let transType: String?
//
//    /**
//     If set to “true”, token will be generated and returned in the response
//     
//     Token can be generated only for successful transactions (not for declined transactions)
//     */
//    let isGenerateToken: Bool
//    let preauth: Bool?
//}
