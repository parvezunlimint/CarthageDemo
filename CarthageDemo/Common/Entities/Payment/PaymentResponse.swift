//
//  PaymentResponse.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 14.10.2020.
//

import Foundation

struct PaymentResponse: MappingProtocol {
    private enum CodingKeys: String, CodingKey {
        case paymentData = "payment_data"
        case redirectUrl = "redirect_url"
    }

    struct PaymentData: Codable {
        let id: String
        let status: String
    }

    let paymentData: PaymentData
    let redirectUrl: URL
}
