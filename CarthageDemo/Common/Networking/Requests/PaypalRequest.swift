//
//  PaypalRequest.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.03.2021.
//

import Foundation

struct PaypalPaymentRequest: Codable {
    private enum CodingKeys: String, CodingKey {
        case request
        case merchantOrder = "merchant_order"
        case paymentMethod = "payment_method"
        case paymentData = "payment_data"
        case customer
        case returnUrls = "return_urls"
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
    /*
     Customer data
     */
    let customer: PaypalPaymentCustomer
    /**
     Return URL's

     Return URLs are the URLs where customer returns by pressing “Back to the shop” or “Cancel” button in Payment Page mode and redirected automatically in Gateway mode
     */
    let returnUrls: ReturnUrls
}
