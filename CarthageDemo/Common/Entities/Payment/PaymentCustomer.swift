//
//  Customer.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 28.09.2020.
//

import Foundation

/**
 Customer data model
 */
public struct PaymentCustomer: Codable {
    private enum CodingKeys: String, CodingKey {
        case email
        case locale
        case homePhone = "home_phone"
        case workPhone = "work_phone"
        case phone
        case ipAddress = "ip"
        case customerID = "id"
    }

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
     The  phone number provided by the Cardholder.
     Characters format: recommended to send phone number in following format "+1 111111111" with country code and subscriber sections (only digits are accepted) of the number, "+" as prefix and "space" as delimiter.
     Refer to ITU-E.164 for additional information on format and length.
     */
    public let phone: String?
    public let ipAddress: String?
    public let customerID: String?
    /**
     Initializer
     */
    public init(homePhone: String?,
                workPhone: String?,
                email: String,
                locale: String?,
                phone: String?,
                ipAddress: String?,
                customerID: String?) {
        self.homePhone = homePhone
        self.workPhone = workPhone
        self.email = email
        self.locale = locale
        self.phone = phone
        self.ipAddress = ipAddress
        self.customerID = customerID
    }
}
