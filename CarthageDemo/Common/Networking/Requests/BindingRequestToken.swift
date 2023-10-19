//
//  BindingRequest.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 03.10.2020.
//

import Foundation

struct BindingRequestToken: Codable {
    private enum CodingKeys: String, CodingKey {
        case request
        case merchantOrder = "merchant_order"
        case recurringData = "payment_data"
        case cardAccount = "card_account"
        case customer = "customer"
        case returnUrls = "return_urls"
    }
    
    struct CardAccount: Codable {
        private enum CodingKeys: String, CodingKey {
            case card
            case billingAddress = "billing_address"
        }
        
        let card: Card
        let billingAddress: BillingAddress?
    }
    
    struct RecurringData: Codable {
        let currency: String
    }
    
    let request: Request
    let merchantOrder: BindingMethodData.MerchantOrder?
    let recurringData: RecurringData
    let cardAccount: CardAccount
    let customer: BindingCustomer
    let returnUrls: ReturnUrls
}
