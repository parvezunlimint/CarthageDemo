//
//  CheckoutDomain.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 10.06.2021.
//

import Foundation

public class CheckoutDomain {

    public typealias CheckoutClosure = (Result<[AvailablePaymentMethod], UnlimintErrors>) -> Void

    // MARK: Public properties

    // MARK: Internal properties

    // MARK: Private properties

    private let mobieToken: String

    private let checkoutUseCase: CheckoutRequestUseCaseProtocol = CheckoutRequestUseCase()

    // MARK: Init & Override

    public init(with mobieToken: String) {
        self.mobieToken = mobieToken
    }

}

public extension CheckoutDomain {

    func availableMethods(completion: @escaping CheckoutClosure) {
        checkoutUseCase.checkMethods(token: mobieToken) { result in
            switch result {
            case let .success(model):
                completion(.success(model.paymentMethods.compactMap {
                    try? $0.result.get()
                }))

            case let .failure(error):
                completion(.failure(error.unlimintError()))
            }
        }
    }

}
