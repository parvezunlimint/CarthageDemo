//
//  Encodable.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 05.10.2020.
//

import Foundation

public extension String {

    /**
     Simple extension for serialization in json
     */
    var json: [String: Any] {
        do {
            guard
                let jsonData = data(using: .utf8),
                let jsonString = try JSONSerialization
                    .jsonObject(with: jsonData,
                                options: [])
                    as? [String: Any] else {
                return [:]
            }
            return jsonString
        } catch {
            return [:]
        }
    }
}

public extension Encodable {

    /**
     Simple extension for serialization in json
     */
    var json: [String: Any] {
        do {
            let jsonData = try JSONEncoder().encode(self)
            guard let jsonString = try JSONSerialization
                    .jsonObject(with: jsonData,
                                options: [])
                    as? [String: Any] else {
                return [:]
            }
            return jsonString
        } catch {
            return [:]
        }
    }
}
