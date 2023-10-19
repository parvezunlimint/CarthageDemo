//
//  Card.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 13.10.2020.
//

import Foundation

struct Card: Codable {
    private enum CodingKeys: String, CodingKey {
        case pan
        case holder
        case securityCode = "security_code"
        case expiration
    }
    /**
     Customer’s card number (PAN). Any valid card number, may contain spaces
     */
    let pan: String?
    /**
     Customer’s cardholder name. Any valid cardholder name
     */
    let holder: String?
    /**
     Customer’s CVV2 / CVC2/ CAV2
     
     Should be 4-digits for card with card brand American Express
     Optional for China UnionPay bank cards
     */
    let securityCode: String
    /**
     Customer’s card expiration date. Format: mm/yyyy
     
     Optional for China UnionPay bank cards
     See validation rules for this field above in API.CR.05-06 in common requirements table
     */
    let expiration: String

    static func string(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"

        return formatter.string(from: date)
    }
}
