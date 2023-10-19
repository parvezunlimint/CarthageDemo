//
//  BindingCustomer.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 30.11.2020.
//

import Foundation

/**
 Binding customer data model
 */
public struct BindingCustomer: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case locale
        case phone
        case homePhone = "home_phone"
        case workPhone = "work_phone"
    }

    /**
     Customer ID is a unique identifier of a cardholder at the Recurring payments service. Each card used by a cardholder within the service is linked to Customer ID and Filing ID.
     */
    public let id: String

    /**
     Customer’s e-mail address
     Optional for wallets where setting in PM "May omit customer email" is enabled
     */
    public let email: String

    /**
     Preferred locale for the payment page (ISO 639-1 language code).
     The default locale (en or other locale if it's set as default in Merchant account) will be applied if the selected locale (received in request) is not supported.
     Supported locales are: ar, az, bg, cs, de, el, en, es, fr, hu, hy, id, it, ja, ka, ko, ms, nl, pl, pt, ro, ru, sr, sv, th, tr, uk, vi, zh
     */
    public let locale: String?

    /**
     Customer’s phone number
     Recommended to send phone number in following format "+1 111111111" with country code and subscriber sections (only digits are accepted) of the number, "+" as prefix and "space" as delimiter.
     Refer to ITU-E.164 for additional information on format and length.
     Mandatory for wallets where setting in PM "May omit customer email" is enabled and customer.email isn't presented in request
     */
    public let phone: String?

    /**
     The home phone number provided by the Cardholder. Required (if available) unless market or regional mandate restricts sending this information.
     Characters format: recommended to send phone number in following format "+1 111111111" with country code and subscriber sections (only digits are accepted) of the number, "+" as prefix and "space" as delimiter.
     Refer to ITU-E.164 for additional information on format and length.
     Field will be ignored if filing.id is presented in request (continue one-click scenario)
     */
    public let homePhone: String?

    /**
     The work phone number provided by the Cardholder. Required (if available) unless market or regional mandate restricts sending this information.
     Characters format: recommended to send phone number in following format "+1 111111111" with country code and subscriber sections (only digits are accepted) of the number, "+" as prefix and "space" as delimiter.
     Refer to ITU-E.164 for additional information on format and length.
     Field will be ignored if filing.id is presented in request (continue one-click scenario)
     */
    public let workPhone: String?

    /**
     Initializer
     */
    public init(id: String,
                email: String,
                locale: String? = nil,
                phone: String? = nil,
                homePhone: String? = nil,
                workPhone: String? = nil) {
        self.id = id
        self.email = email
        self.locale = locale
        self.phone = phone
        self.homePhone = homePhone
        self.workPhone = workPhone
    }
}
