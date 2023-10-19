//
//  CardBindingResponce.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 05.10.2020.
//

import Foundation

struct CardBindingResponse: MappingProtocol {
    private enum CodingKeys: String, CodingKey {
        case recurringData = "recurring_data"
        case redirectUrl = "redirect_url"
    }

    struct RecurringData: Codable {
        let id: String
    }

    let recurringData: RecurringData
    let redirectUrl: String
}
