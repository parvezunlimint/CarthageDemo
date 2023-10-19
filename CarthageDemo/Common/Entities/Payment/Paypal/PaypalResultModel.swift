//
//  PaypalResultModel.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 13.05.2021.
//

import Foundation

/**
 Data model
 */
public struct PaypalResultModel {

    /**
     Id for recurring
     */
    public let paymentId: String

    /**
     Is url for completing operation with WebView
     */
    public let redirectUrl: URL
}
