//
//  PaymentResultModel.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 12.05.2021.
//

import Foundation

/**
 Data model
 */
public struct PaymentResultModel {

    /**
     Id for recurring
     */
    public let paymentId: String

    /**
     Is url for completing operation with WebView
     */
    public let redirectUrl: URL
}
