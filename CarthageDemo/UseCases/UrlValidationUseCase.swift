//
//  UrlValidationUseCase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 30.04.2021.
//

import Foundation

class UrlValidationUseCase {
    func isValid(url: URL) -> Bool {
        let cardpayUrl = ApiEndpoints.baseUrl
        let unlimintUrl = URL(string: ApiEndpoints
                                .baseUrl
                                .absoluteString
                                .replacingOccurrences(of: "cardpay",
                                                      with: "unlimint"))!

        return (cardpayUrl.host == url.host || unlimintUrl.host == url.host) &&
            (cardpayUrl.scheme == url.scheme || unlimintUrl.scheme == url.scheme)
    }
}
