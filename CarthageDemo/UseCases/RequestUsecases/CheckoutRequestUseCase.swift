//
//  CheckoutRequestUseCase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 10.06.2021.
//

import Foundation

protocol CheckoutRequestUseCaseProtocol {

    func checkMethods(token: String,
                      completion: @escaping (Result<CheckoutResponse, NetworkError>) -> Void)

}

class CheckoutRequestUseCase: CheckoutRequestUseCaseProtocol {

    // MARK: Private properties

    private let network: NetworkService<ApiEndpoints> = .init()

}

extension CheckoutRequestUseCase {

    func checkMethods(token: String,
                      completion: @escaping (Result<CheckoutResponse, NetworkError>) -> Void) {
        network.request(.checkout(token), completion: completion)
    }

}
