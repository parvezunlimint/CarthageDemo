//
//  PaymentRequestUseCase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 30.04.2021.
//

import Foundation

protocol PaymentRequestUseCaseProtocol {
    func pay(request: (token: String, data: Codable),
             completion: @escaping (Result<PaymentResponse, NetworkError>) -> Void)
}

class PaymentRequestUseCase {

    // MARK: Private properties

    private let network: NetworkService<ApiEndpoints> = .init()
}

extension PaymentRequestUseCase: PaymentRequestUseCaseProtocol {
    func pay(request: (token: String, data: Codable),
             completion: @escaping (Result<PaymentResponse, NetworkError>) -> Void) {
        network.request(.payment(request.token, request.data), completion: completion)
    }
}
