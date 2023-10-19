//
//  PaymentRequest.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.10.2020.
//

import Foundation

struct RecurringTokenPaymentRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case request
        case merchantOrder = "merchant_order"
        case paymentMethod = "payment_method"
        case paymentData = "payment_data"
        case cardAccount = "card_account"
        case customer
        case returnUrls = "return_urls"
        case recurringData = "recurring_data"
    }

    struct CardAccount: Codable {
        private enum CodingKeys: String, CodingKey {
            case token
            case card
            case billingAddress = "billing_address"
        }
        /**
         Card token value, used instead of card information, except card.security_code (it's mandatory)
         */
        let token: String
        /**
         Represents a payment card data. Card section shouldn't be present if element token was presented.
         
         Group of fields is mandatory in Gateway mode and shouldn't be used in Payment Page mode.
         For recurring: all card elements should presented only for first recurring payment.
         */
        let card: TokenizedCard
        /**
         Billing Address
         */
        let billingAddress: BillingAddress?
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
    let customer: RecurringCustomer
    /**
     Return URL's
     
     Return URLs are the URLs where customer returns by pressing “Back to the shop” or “Cancel” button in Payment Page mode and redirected automatically in Gateway mode
     */
    let returnUrls: ReturnUrls
    
    
    let recurringData: RecurringData
}
