//
//  PaypalPaymentMethodData.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 12.03.2021.
//

import Foundation

/**
 Data model
 */
public struct PaypalPaymentMethodData: Codable {

    /**
     The name of the merchant
     */
    public let merchantName: String

    /**
     Merchant order data
     */
    public let merchantOrder: PaymentMerchantOrder

    /**
     Payment method type name
     */
    public let paymentMethod: String

    /**
     Payment data
     */
    public let paymentData: PaymentData

    /**
     Customer data
     */
    public var customer: PaypalPaymentCustomer

    /**
     Initializer for model
     */
    public init(merchantName: String,
                merchantOrder: PaymentMerchantOrder,
                paymentMethod: String,
                paymentData: PaymentData,
                customer: PaypalPaymentCustomer) {
        self.merchantName = merchantName
        self.merchantOrder = merchantOrder
        self.paymentMethod = paymentMethod
        self.paymentData = paymentData
        self.customer = customer
    }
}
