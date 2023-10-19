//
//  ApiEndpoints.swift
//  Alamofire
//
//  Created by Denis Gnezdilov on 03.10.2020.
//

import Foundation
import Moya

protocol ApiEndpointsProtocol: TargetType {
    var token: String { get }
}

enum ApiEndpoints: ApiEndpointsProtocol {
    case binding(String, BindingRequest)
    case bindingToken(String, BindingRequestToken)
    case payment(String, Codable)
    case checkout(String)
    case recurring(String, Codable)
}

extension ApiEndpoints {
    static var baseUrl: URL {
        URL(string: Environments
                .current
                .baseString)!
    }

    var baseURL: URL {
        Self.baseUrl
    }
    var token: String {
        switch self {
        case let .binding(token, _),
             let .bindingToken(token, _),
             let .payment(token, _),
             let .checkout(token),
             let .recurring(token, _):
            return token
        }
    }
    var path: String {
        switch self {
        case .binding:
            return "/api/mobile/cardbinding"
        case .bindingToken:
            return "/api/mobile/cardbinding"
        case .payment:
            return "/api/mobile/payment"
        case .checkout:
            return "/api/mobile/payment_methods"
        case .recurring:
            return "/api/mobile/recurring"
        }
    }
    var method: Moya.Method {
        switch self {
        case .binding,
             .bindingToken,
             .payment,
             .recurring:
            return .post
        case .checkout:
            return .get
        }
    }
    var sampleData: Data {
        Data()
    }
    var task: Task {
        switch self {
        case let .binding(_, params):
            return .requestParameters(parameters: params.json, encoding: JSONEncoding.default)
        case let .bindingToken(_, params):
            return .requestParameters(parameters: params.json, encoding: JSONEncoding.default)
        case let .payment(_, params):
            return .requestParameters(parameters: params.json, encoding: JSONEncoding.default)
        case .checkout:
            return .requestPlain
        case let .recurring(_, params):
            return .requestParameters(parameters: params.json, encoding: JSONEncoding.default)
            
        }
    }
    var headers: [String: String]? {
        let versionName = frameworkBundle.infoDictionary?["CFBundleShortVersionString"] ?? "unknown"
        return [
            "Content-Type": "application/json",
            "Authorization": "Mobile \(token)",
            "User-Agent": "UnlimintMobileSdk/\(versionName)/IOS"
        ]
    }
}
