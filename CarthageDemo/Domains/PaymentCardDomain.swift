//
//  PaymentCardDomain.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 21.04.2021.
//

import Foundation

/**
 Pay with bank card or bank card token

 Payment flow consists of 3 consecutive steps:

 - pay(for type: PayTypes, completion: @escaping PaymentClosure) - send bank card data (requisites or token) and another payment data
 - show WebView with redirectUrl from first step
 - onUserNavigateTo(url: URL) - Check result of payment operation by redirect url from webView
 */
public class PaymentCardDomain {

    /// Completion closure for payment method
    public typealias PaymentClosure = (Result<PaymentResultModel, UnlimintErrors>) -> Void

    /// Payment variants for methods
    public enum PayTypes {
        /// Payment with card token
        case token(requisites: TokenPaymentRequisites, data: PaymentTokenMethodData)
        /// Payment with card
        case card(requisites: CardPaymentRequisites, data: PaymentMethodData)
    }

    // MARK: Private properties

    private let mobieToken: String
    private let paymentRequestUseCase: PaymentRequestUseCaseProtocol = PaymentRequestUseCase()
    private let urlValidationUseCase: UrlValidationUseCase = .init()
    private let webValidationUseCase: WebValidationUseCase = .init(results: [
        URL(string: "https://www.unlimint.com/success")!: .success,
        URL(string: "https://www.unlimint.com/decline")!: .decline
    ])

    // MARK: Init & Override
    /**
     Domain initializer.

     - parameter token: Mobile token generated on the merchant's server

     # Notes: #
     - The mobile token is a one-time token

     */
    public init(token: String) {
        mobieToken = token
    }
}

public extension PaymentCardDomain {
    /**

     - parameter type: Payment variant
     - parameter completion: Callback of result payment request
     - warning: Completion closure does not guarantee the result will be returned on the main queue.

     */
    func pay(for type: PayTypes,
             completion: @escaping PaymentClosure) {
        let request: Codable = {
            switch type {
            case let .card(requisites: requisites, data: data):
                return buildCardPaymentRequest(for: requisites, data: data)

            case let .token(requisites: requisites, data: data):
                return buildTokenPaymentRequest(for: requisites, data: data)
            }
        }()

        pay(for: request, completion: completion)
    }

    /**
     Check result of operation by redirect url from webView.

     - parameter url: URL by which the redirect to the webView occurs.
     - returns: WebNavigationResult: URL verification result

     */
    func onUserNavigateTo(url: URL) -> WebNavigationResults {
        webValidationUseCase[url] ?? .skip
    }
}

private extension PaymentCardDomain {
    func pay(for request: Codable,
             completion: @escaping PaymentClosure) {
        paymentRequestUseCase.pay(request: (mobieToken, request)) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .success(model):
                guard let redirectUrl = try? model.redirectUrl.asURL(),
                      self.urlValidationUseCase.isValid(url: redirectUrl) else {
                    completion(.failure(.security([
                        "info": "Serialisation data error"
                    ])))
                    return
                }

                completion(.success(.init(paymentId: model.paymentData.id,
                                          redirectUrl: redirectUrl)))

            case let .failure(error):
                completion(.failure(error.unlimintError()))
            }
        }
    }

    func buildTokenPaymentRequest(for requisites: TokenPaymentRequisites,
                                  data: PaymentTokenMethodData) -> PaymentTokenRequest {
        return PaymentTokenRequest(request: .init(),
                                   merchantOrder: data.merchantOrder,
                                   paymentMethod: data.paymentMethod,
                                   paymentData: data.paymentData,
                                   cardAccount: .init(token: data.cardAccount.token,
                                                      card: .init(securityCode: requisites.cvc),
                                                      billingAddress: data.cardAccount.billingAddress),
                                   customer: data.customer,
                                   returnUrls: .init(successUrl: webValidationUseCase[.success]?.absoluteString,
                                                     declineUrl: webValidationUseCase[.decline]?.absoluteString))
    }

    func buildCardPaymentRequest(for requisites: CardPaymentRequisites,
                                 data: PaymentMethodData) -> PaymentRequest {
        return PaymentRequest(request: .init(),
                              merchantOrder: data.merchantOrder,
                              paymentMethod: data.paymentMethod,
                              paymentData: .init(amount: data.paymentData.amount,
                                                 currency: data.paymentData.currency,
                                                 note: data.paymentData.note,
                                                 dynamicDescriptor: data.paymentData.dynamicDescriptor,
                                                 transType: data.paymentData.transType,
                                                 isGenerateToken: requisites.isGenerateToken,
                                                 preauth: data.paymentData.preauth),
                              cardAccount: .init(card: .init(pan: requisites.cardNumber,
                                                             holder: data.merchantName,
                                                             securityCode: requisites.cvc,
                                                             expiration: Card
                                                                .string(from: requisites.expireDate)),
                                                 billingAddress: nil),
                              customer: data.customer,
                              returnUrls: .init(returnUrl: nil,
                                                successUrl: webValidationUseCase[.success]?.absoluteString,
                                                declineUrl: webValidationUseCase[.decline]?.absoluteString))
    }
}
