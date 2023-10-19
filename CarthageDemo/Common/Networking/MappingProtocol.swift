//
//  MappingProtocol.swift
//  Alamofire
//
//  Created by Denis Gnezdilov on 02.10.2020.
//

import Foundation

protocol MappingProtocol: Codable {
}

extension MappingProtocol {
    static func from(data: Data) throws -> Self {
        let decoder = JSONDecoder()

        return try decoder.decode(Self.self, from: data)
    }

    static func from(dictionary: [String: Any]) throws -> Self {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return try from(data: jsonData)
    }
}
