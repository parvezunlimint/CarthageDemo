//
//  BindingResult.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 26.04.2021.
//

import Foundation

/**
 * Exceptions that can be thrown by Unlimint Sdk
 */
public enum UnlimintErrors: Error, CustomDebugStringConvertible {

    /**
     Unauthorized exception

     - parameter token: token, which was used in request

     */
    case unauthorized(token: String)

    /**
     * Security exception
     */
    case security([String: String])

    /**
     * Some io errors
     */
    case serviceUnavailable

    /**
     * Error while handling requisites data
     */
    case invalidData(Error)

    /**
     * No internet connection
     */
    case networkConnection(Error)

    /**
     * Wrapper for all internal errors in sdk
     */
    case `internal`(Error)

    public var debugDescription: String {
        switch self {
        case let .unauthorized(token: token):
            return "unauthorized token: \(token)"

        case let .security(dic):
            return "Security error:\n\(dic)"

        case .serviceUnavailable:
            return "Service unavailable"

        case let .invalidData(error):
            return "InvalidData: \(String(describing: error._userInfo))"

        case let .networkConnection(error):
            return "Network connection: \(error.localizedDescription)"

        case let .internal(error):
            return "Internal: \(error.localizedDescription)"
        }
    }
}

extension NetworkError {
    func unlimintError() -> UnlimintErrors {
        switch self {
        case let .unauthorizedToken(token):
            return .unauthorized(token: token)

        case .serialisation:
            return .invalidData(NSError.unlimint(userInfo: [
                "info": "Serialisation data error"
            ]))

        case let .network(error):
            return .networkConnection(error)

        case let .api(error, code):
            if (300...399).contains(code) || (402...499).contains(code) {
                return .internal(NSError.unlimint())
            } else if 400 == code {
                return .invalidData(error)
            } else if (500...599).contains(code) {
                return .serviceUnavailable
            } else {
                return .internal(NSError.unlimint())
            }
        }
    }
}
