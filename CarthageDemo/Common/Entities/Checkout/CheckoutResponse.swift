//
//  CheckoutResponse.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 10.06.2021.
//

import Foundation

struct CheckoutResponse: MappingProtocol {

    private enum CodingKeys: String, CodingKey {
        case paymentMethods = "payment_methods"
    }

    let paymentMethods: [Throwable<AvailablePaymentMethod>]

}
