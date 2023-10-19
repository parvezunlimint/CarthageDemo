//
//  PaymentMerchantOrder.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 30.11.2020.
//

import Foundation

/**
 Shipping address data model
 */
public struct ShippingAddress: Codable {
    private enum ConingKeys: String, CodingKey {
        case country
        case state
        case zip
        case city
        case phone
        case addrLine1 = "addr_line_1"
        case addrLine2 = "addr_line_2"
    }

    /**
     ISO 3166-1 code of delivery country: 2 or 3 latin letters or numeric code
     Required for BANKCARD payment method, if shipping_address is presented
     */
    public let country: String?

    /**
     The state or province of the shipping address associated with the card being used for this purchase.
     It's recommended to send in following format: The country subdivision code defined in ISO 3166-2.
     May include whitespaces, hyphens, apostrophes, commas and dots
     */
    public let state: String?

    /**
     Delivery postal code.
     For BANKCARD payment method - max length 12
     */
    public let zip: String?

    /**
     Delivery city. May include whitespaces, hyphens, apostrophes, commas and dots
     */
    public let city: String?

    /**
     Valid customer phone number
     */
    public let phone: String?

    /**
     First line of the street address or equivalent local portion of the Cardholder shipping address associated with the card used for this purchase. Can include street and house number
     */
    public let addrLine1: String?

    /**
     Second line of the street address or equivalent local portion of the Cardholder shipping address associated with the card used for this purchase.
     */
    public let addrLine2: String?
}

/**
 Item data model
 */
public struct Item: Codable {
    /**
     The name of product / service, provided to the customer
     */
    public let name: String

    /**
     The description of product / service, provided to the customer
     */
    public let description: String?

    /**
     The count of product / service, provided to the customer. Any positive number
     */
    public let count: Int?

    /**
     Price of product / service with dot as a decimal separator, must be less than a million
     */
    public let price: Float?
}

/**
 Payment merchant order data model
 */
public struct PaymentMerchantOrder: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case shippingAddress = "shipping_address"
        case items
    }

    /**
     Order ID used by the merchant's shopping cart
     */
    public let id: String

    /**
     Description of product/service being sold
     */
    public let description: String

    /**
     Shipping Address
     */
    public let shippingAddress: ShippingAddress?

    /**
     Array of items (in the shopping cart)
     */
    public let items: [Item]?

    /**
     Initializer
     */
    public init(description: String,
                id: String,
                shippingAddress: ShippingAddress? = nil,
                items: [Item]? = nil) {
        self.description = description
        self.id = id
        self.shippingAddress = shippingAddress
        self.items = items
    }
}

/**
 Payment data model
 */
public struct PaymentData: Codable {
    private enum CodingKeys: String, CodingKey {
        case amount
        case currency
        case note
        case dynamicDescriptor = "dynamic_descriptor"
        case transType = "trans_type"
        case isEditable
        case preauth
    }

    /**
     The total transaction amount in selected currency with dot as a decimal separator, must be less than 100 millions
     */
    public let amount: Decimal

    /**
     ISO 4217 currency code
     */
    public let currency: String

    /**
     Note about the transaction that will not be displayed to customer
     */
    public let note: String?

    /**
     Short description of the service or product, must be enabled by Unlimint manager to be used.
     For Visa cards: maximum length 25 symbols, for MasterCard cards - 22 symbols.
     */
    public let dynamicDescriptor: String?

    /**
     Identifies the type of transaction being authenticated.
     
     Values accepted:
     - 01 - Goods/ Service Purchase
     - 03 - Check Acceptance
     - 10 - Account Funding • 11 = Quasi-Cash Transaction
     - 28 - Prepaid Activation and Load Note: Values derived from the 8583 ISO Standard.
     */
    public let transType: String?

    public let isEditable: Bool

    /**
            2 phase authentication
     */
    public let preauth: Bool?
    /**
     Initializer
     */
    public init(amount: Decimal,
                currency: String,
                note: String?,
                dynamicDescriptor: String?,
                transType: String?,
                isEditable: Bool = false,
                preauth: Bool = false) {
        self.amount = amount
        self.currency = currency
        self.note = note
        self.dynamicDescriptor = dynamicDescriptor
        self.transType = transType
        self.isEditable = isEditable
        self.preauth = preauth
    }
}
