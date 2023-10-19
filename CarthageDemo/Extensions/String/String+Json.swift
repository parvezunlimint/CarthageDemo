//
//  String+json.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 05.10.2020.
//

import Foundation

extension String {
    func toJson() -> Any? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: [])
    }
}
