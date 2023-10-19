//
//  AvailablePaymentMethod.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 10.06.2021.
//

import Foundation

public struct AvailablePaymentMethod: MappingProtocol {

    private enum CodingKeys: String, CodingKey {

        case name

    }

    public enum MethodName: String {

        case bankCard

        case payPal

        case unknown

    }

    public let name: MethodName

    // MARK: Init & Override

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        switch try values.decode(String.self, forKey: .name).uppercased() {
        case MethodName.bankCard.rawValue.uppercased():
            name = .bankCard

        case MethodName.payPal.rawValue.uppercased():
            name = .payPal

        default:
            name = .unknown
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name.rawValue.uppercased(), forKey: .name)
    }
}
