//
//  RequestUseCase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 23.04.2021.
//

import Foundation

protocol BindingRequestUseCaseProtocol {
    
    func bind(request: (token: String, data: BindingRequest),
              completion: @escaping (Result<CardBindingResponse, NetworkError>) -> Void)
    func bind(request: (token: String, data: BindingRequestToken),
              completion: @escaping (Result<CardBindingResponseToken, NetworkError>) -> Void)

}

class BindingRequestUseCase {

    // MARK: Private properties

    private let network: NetworkService<ApiEndpoints> = .init()
}

extension BindingRequestUseCase: BindingRequestUseCaseProtocol {
    
    func bind(request: (token: String, data: BindingRequest),
              completion: @escaping (Result<CardBindingResponse, NetworkError>) -> Void) {
        network.request(.binding(request.token, request.data), completion: completion)
    }
    func bind(request: (token: String, data: BindingRequestToken),
              completion: @escaping (Result<CardBindingResponseToken, NetworkError>) -> Void) {
        network.request(.bindingToken(request.token, request.data), completion: completion)
    }
}
