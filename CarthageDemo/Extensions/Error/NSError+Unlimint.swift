//
//  NSError+Unlimint.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 30.04.2021.
//

import Foundation

extension NSError {
    static func unlimint(userInfo: [String: Any]? = nil) -> NSError {
        NSError(domain: "unlimint", code: 666, userInfo: userInfo)
    }
}
