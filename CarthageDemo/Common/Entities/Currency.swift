//
//  Currency.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 28.09.2020.
//

import Foundation

/**
 Currency data model
 */
public struct Currency: Codable {

    /**
     ISO 4217 currency code
     */
    public let value: String

    /**
     Initializer
     */
    public init(with value: String) {
        self.value = value
    }
}
