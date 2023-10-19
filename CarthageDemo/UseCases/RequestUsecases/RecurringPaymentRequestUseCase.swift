//
//  PaymentRequestUseCase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 30.04.2021.
//

import Foundation

protocol RecurringPaymentRequestUseCaseProtocol {
    func pay(request: (token: String, data: Codable),
             completion: @escaping (Result<RecurringResponse, NetworkError>) -> Void)
}

class RecurringPaymentRequestUseCase {

    // MARK: Private properties

    private let network: NetworkService<ApiEndpoints> = .init()
}

extension RecurringPaymentRequestUseCase: RecurringPaymentRequestUseCaseProtocol {
    func pay(request: (token: String, data: Codable),
             completion: @escaping (Result<RecurringResponse, NetworkError>) -> Void) {
        network.request(.recurring(request.token, request.data), completion: completion)
    }
}
