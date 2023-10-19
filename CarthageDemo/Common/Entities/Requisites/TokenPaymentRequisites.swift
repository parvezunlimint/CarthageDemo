//
//  TokenPaymentRequisites.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 23.04.2021.
//

import Foundation

/**
 Data model, for payment token method
 */
public struct TokenPaymentRequisites {

    /**
     Verification Code
     */
    public let cvc: String

    /**
     Initializer for model
     */
    public init(cvc: String) {
        self.cvc = cvc
    }

}
