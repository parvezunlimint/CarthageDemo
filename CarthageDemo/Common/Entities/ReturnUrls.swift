//
//  ReturnUrls.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 30.11.2020.
//

import Foundation

struct ReturnUrls: Codable {
    private enum CodingKeys: String, CodingKey {
        case returnUrl = "return_url"
        case successUrl = "success_url"
        case declineUrl = "decline_url"
        case cancelUrl = "cancel_url"
        case inprocessUrl = "inprocess_url"
    }
    /**
     Overrides default success URL, decline URL, cancel URL (only in Payment page mode), inprocess URL
     
     Return_url can be used separately or together with other url parameters
     */
    let returnUrl: String?
    /**
     Overrides default success URL only
     */
    let successUrl: String?
    /**
     Overrides default decline URL only
     */
    let declineUrl: String?
    /**
     Overrides default cancel URL only
     */
    let cancelUrl: String?
    /**
     Special URL for In process status of transaction
     */
    let inprocessUrl: String?

    init(returnUrl: String? = nil,
         successUrl: String? = nil,
         declineUrl: String? = nil,
         cancelUrl: String? = nil,
         inprocessUrl: String? = nil) {
        self.returnUrl = returnUrl
        self.successUrl = successUrl
        self.declineUrl = declineUrl
        self.cancelUrl = cancelUrl
        self.inprocessUrl = inprocessUrl
    }
}
