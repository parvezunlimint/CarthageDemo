//
//  NetworkService.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 02.10.2020.
//

import Foundation
import Moya
import Alamofire

enum NetworkError: Error {
    case api(Error, Int)
    case serialisation(Error, Int)
    case network(Error)
    case unauthorizedToken(String)
}

class NetworkService<Endpoints> where Endpoints: ApiEndpointsProtocol {
    // MARK: Private properties
    private let provider: MoyaProvider<Endpoints> = .init(callbackQueue:
                                                            .global(qos: .utility),

                                                          session:
                                                            Session(serverTrustManager:
                                                                        ServerTrustManager(
                                                                            evaluators:
                                                                                Environments
                                                                                .current
                                                                                .evaluators
                                                                        )
                                                            ),
                                                          plugins: Environments.current.plugins)
    private var activeRequests: [Cancellable] = .init()

    deinit {
        activeRequests.forEach { $0.cancel() }
    }
}

extension NetworkService {
    func request<T: MappingProtocol>(_ endpoint: Endpoints,
                                     completion: @escaping (Result<T, NetworkError>) -> Void) {
        let request = provider.request(endpoint) { [weak self] result in
            switch result {
            case let .success(moyaResponse):
                self?.handle(endpoint: endpoint, response: moyaResponse, completion: completion)

            case let .failure(error):
                completion(.failure(NetworkError.network(error)))
            }
        }

        activeRequests.append(request)
    }
}

extension NetworkService {
    private func handle<T: MappingProtocol>(endpoint: Endpoints,
                                            response: Moya.Response,
                                            completion: @escaping (Result<T, NetworkError>) -> Void) {
        switch response.statusCode {
        case 200:
            let data = response.data

//            let str = String(decoding: data, as: UTF8.self)
//            print(str)
            do {
                let decodedJson = try T.from(data: data)
                return completion(.success(decodedJson))
            } catch {
                completion(.failure(NetworkError.serialisation(error, response.statusCode)))
            }

        case 401:
            let token = endpoint.token

            completion(.failure(NetworkError.unauthorizedToken(token)))

        default:
            let error = NSError(domain: "Unlimint",
                                code: response.statusCode,
                                userInfo: try? JSONSerialization.jsonObject(with: response.data,
                                                                            options: []) as? [String: Any])

            completion(.failure(NetworkError.api(error, response.statusCode)))
        }
    }
}
