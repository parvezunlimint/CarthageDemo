//
//  PaymentRequest.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.10.2020.
//

import Foundation

struct PaymentRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case request
        case merchantOrder = "merchant_order"
        case paymentMethod = "payment_method"
        case paymentData = "payment_data"
        case cardAccount = "card_account"
        case customer
        case returnUrls = "return_urls"
    }

    struct CardAccount: Codable {
        private enum CodingKeys: String, CodingKey {
            case card
            case billingAddress = "billing_address"
        }
        /**
         Represents a payment card data. Card section shouldn't be present if element token was presented.
         
         Group of fields is mandatory in Gateway mode and shouldn't be used in Payment Page mode.
         For recurring: all card elements should presented only for first recurring payment.
         */
        let card: Card
        /**
         Billing Address
         */
        let billingAddress: BillingAddress?
    }

    struct PaymentData: Codable {
        private enum CodingKeys: String, CodingKey {
            case amount
            case currency
            case note
            case dynamicDescriptor = "dynamic_descriptor"
            case transType = "trans_type"
            case isGenerateToken = "generate_token"
            case preauth
        }

        /**
         The total transaction amount in selected currency with dot as a decimal separator, must be less than 100 millions
         */
        let amount: Decimal
        /**
         ISO 4217 currency code
         */
        let currency: String
        /**
         Note about the transaction that will not be displayed to customer
         */
        let note: String?
        /**
         Short description of the service or product, must be enabled by Unlimint manager to be used.
         For Visa cards: maximum length 25 symbols, for MasterCard cards - 22 symbols.
         */
        let dynamicDescriptor: String?
        /**
         Identifies the type of transaction being authenticated.
         
         Values accepted:
         - 01 - Goods/ Service Purchase
         - 03 - Check Acceptance
         - 10 - Account Funding • 11 = Quasi-Cash Transaction
         - 28 - Prepaid Activation and Load Note: Values derived from the 8583 ISO Standard.
         */
        let transType: String?

        /**
         If set to “true”, token will be generated and returned in the response
         
         Token can be generated only for successful transactions (not for declined transactions)
         */
        let isGenerateToken: Bool
        
        
        let preauth: Bool?
    }

    /**
     * Request data
     */
    let request: Request
    /**
     Merchant order data
     */
    let merchantOrder: PaymentMerchantOrder
    /**
     Payment method type name
     */
    let paymentMethod: String
    /**
     Payment data
     */
    let paymentData: PaymentData
    /**
     Card account data
     */
    let cardAccount: CardAccount
    /**
     Customer data
     */
    let customer: PaymentCustomer
    /**
     Return URL's
     
     Return URLs are the URLs where customer returns by pressing “Back to the shop” or “Cancel” button in Payment Page mode and redirected automatically in Gateway mode
     */
    let returnUrls: ReturnUrls
}
