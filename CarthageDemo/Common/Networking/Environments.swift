//
//  Environments.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 23.04.2021.
//

import Foundation
import Alamofire
import Moya

/**
 List of environments
 */
public enum Environments: String, CaseIterable {
    /// Case for testing the functionality
    case sandbox
    #if PRODUCTION
    /// Case for production
    case production
    #else
    case testCyprus = "Test CY"
    case testCyprusNon3dsBinding = "Test CY _non3ds_bindings"
    case nsk = "NSK"
    #endif
}

public extension Environments {

    /**
     You can use this property to set the environments that the SDK should run on.
     */
    static var current: Environments = .sandbox

}

extension Environments {

    var evaluators: [String: ServerTrustEvaluating] {
        #if PRODUCTION
        [
            "cardpay.com": DefaultTrustEvaluator(),
            "sandbox.cardpay.com": DefaultTrustEvaluator()
        ]
        #else
        [
            "sandbox.cardpay.com": DefaultTrustEvaluator(),
            "test.cardpay-test.com": DefaultTrustEvaluator(),
            "waf-nsk.cardpay-test.com": DefaultTrustEvaluator()
        ]
        #endif
    }

    var plugins: [PluginType] {
        #if PRODUCTION
        [
        ]
        #else
        [
            NetworkLoggerPlugin()
        ]
        #endif
    }

    var baseString: String {
        switch self {
        case .sandbox:
            return "https://sandbox.cardpay.com"
        #if PRODUCTION
        case .production:
            return "https://cardpay.com"

        #else
        case .testCyprus,
             .testCyprusNon3dsBinding:
            return "https://test.cardpay-test.com"

        case .nsk:
            return "https://waf-nsk.cardpay-test.com"
        #endif
        }
    }
}
