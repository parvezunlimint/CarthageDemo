//
//  PaypalRequestUsecase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 13.05.2021.
//

import Foundation

protocol PayPalRequestUseCaseProtocol {
    func pay(request: (token: String, data: Codable),
             completion: @escaping (Result<PaymentResponse, NetworkError>) -> Void)
}

class PayPalRequestUseCase: PayPalRequestUseCaseProtocol {

    // MARK: Private properties

    private let network: NetworkService<ApiEndpoints> = .init()
}

extension PayPalRequestUseCase {
    func pay(request: (token: String, data: Codable),
             completion: @escaping (Result<PaymentResponse, NetworkError>) -> Void) {
        network.request(.payment(request.token, request.data), completion: completion)
    }
}
