//
//  Throwable.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 11.06.2021.
//

import Foundation

struct Throwable<T: Codable>: Codable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }

    public func encode(to encoder: Encoder) throws {
        switch result {
        case let .success(data):
            try data.encode(to: encoder)

        case .failure:
            break
        }
    }

}
