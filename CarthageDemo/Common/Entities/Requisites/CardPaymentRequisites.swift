//
//  CardPaymentRequisites.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 10.03.2021.
//

import Foundation

/**
 Data model, for transmitting card details
 */
public struct CardPaymentRequisites {

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
     Flag that indicates whether the card needs to be tokenized.


     # Note #
     - If `true`, card token will be generated.

     */
    public let isGenerateToken: Bool

    /**
     Initializer for model
     */
    public init(cardNumber: String,
                expireDate: Date,
                cvc: String,
                isGenerateToken: Bool) {
        self.cardNumber = cardNumber
        self.expireDate = expireDate
        self.cvc = cvc
        self.isGenerateToken = isGenerateToken
    }
}
