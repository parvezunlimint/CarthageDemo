//
//  BillingAddress.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 05.10.2020.
//

import Foundation

public struct BillingAddress: Codable {
    private enum CodingKeys: String, CodingKey {
        case country
        case state
        case zip
        case city
        case addrLine1 = "addr_line_1"
        case addrLine2 = "addr_line_2"
    }
    /**
     ISO 3166-1 code of billing country: 2 or 3 latin letters or numeric code
     */
    public let country: String
    /**
     The state or province of the billing address associated with the card being used for this purchase.
     It's recommended to sent in following format: The country subdivision code defined in ISO 3166-2.
     May include whitespaces, hyphens, apostrophes, commas and dots
     */
    public let state: String?
    /**
     Billing postal code
     */
    public let zip: String
    /**
     Billing city. May include whitespaces, hyphens, apostrophes, commas and dots
     */
    public let city: String
    /**
     First line of the street address or equivalent local portion of the Cardholder billing address associated with the card used for this purchase.
     May include whitespaces, hyphens, apostrophes, commas, quotes, dots, slashes and semicolons.
     Required (if available) unless market or regional mandate restricts sending this information.
     Field will be ignored if filing.id is presented in request (continue one-click scenario)
     */
    public let addrLine1: String
    /**
     Second line of the street address or equivalent local portion of the Cardholder billing address associated with the card used for this purchase. Required (if available) unless market or regional mandate restricts sending this information.
     Field will be ignored if filing.id is presented in request (continue one-click scenario)
     */
    public let addrLine2: String?

    public init(country: String,
                state: String?,
                zip: String,
                city: String,
                addrLine1: String,
                addrLine2: String?) {
        self.country = country
        self.state = state
        self.zip = zip
        self.city = city
        self.addrLine1 = addrLine1
        self.addrLine2 = addrLine2
    }
}
