//
//  CardRequisites.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 23.04.2021.
//

import Foundation

/**
 Data model, for transmitting card details
 */
public struct CardRequisites {

    /**
     Bank card number
     */
    public let cardNumber: String

    /**
     Expiration date
     */
    public let expireDate: Date

    /**
     Verification Code
     */
    public let cvc: String

    /**
     Initializer for model
     */
    public init(cardNumber: String,
                expireDate: Date,
                cvc: String) {
        self.cardNumber = cardNumber
        self.expireDate = expireDate
        self.cvc = cvc
    }
}
