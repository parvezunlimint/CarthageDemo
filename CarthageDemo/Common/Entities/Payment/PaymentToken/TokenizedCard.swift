//
//  TokenizedCard.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 30.11.2020.
//

import Foundation

struct TokenizedCard: Codable {
    private enum CodingKeys: String, CodingKey {
        case securityCode = "security_code"
    }
    /**
     Customer’s CVV2 / CVC2/ CAV2
     
     Should be 4-digits for card with card brand American Express
     Optional for China UnionPay bank cards
     */
    let securityCode: String
}
