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
public class PaymentCardRecurringDomain {

    /// Completion closure for payment method
    public typealias PaymentClosure = (Result<PaymentResultModel, UnlimintErrors>) -> Void

    /// Payment variants for methods
    public enum PayTypes {
        /// Payment with card token
        case recurringToken(requisites: TokenPaymentRequisites, data: RecurringPaymentTokenMethodData)
        /// Payment with card
        case recurringCard(requisites: CardPaymentRequisites, data: RecurringPaymentMethodData)
    }

    // MARK: Private properties

    private let mobieToken: String
    private let paymentRequestUseCase: RecurringPaymentRequestUseCaseProtocol = RecurringPaymentRequestUseCase()
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

public extension PaymentCardRecurringDomain {
    /**

     - parameter type: Payment variant
     - parameter completion: Callback of result payment request
     - warning: Completion closure does not guarantee the result will be returned on the main queue.

     */
    func pay(for type: PayTypes,
             completion: @escaping PaymentClosure) {
        let request: Codable = {
            switch type {
            case let .recurringCard(requisites: requisites, data: data):
                return buildRecurringCardPaymentRequest(for: requisites, data: data)

            case let .recurringToken(requisites: requisites, data: data):
                return buildRecurringTokenPaymentRequest(for: requisites, data: data)
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

private extension PaymentCardRecurringDomain {
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

                completion(.success(.init(paymentId: model.recurringData.id,
                                          redirectUrl: redirectUrl)))

            case let .failure(error):
                completion(.failure(error.unlimintError()))
            }
        }
    }

    func buildRecurringTokenPaymentRequest(for
                                           requisites: TokenPaymentRequisites,
                                                 data: RecurringPaymentTokenMethodData) -> RecurringTokenPaymentRequest {
        return RecurringTokenPaymentRequest(request: .init(),
                                       merchantOrder: data.merchantOrder,
                                       paymentMethod: data.paymentMethod,
                                       paymentData: data.paymentData,
                                       cardAccount: .init(token: data.cardAccount.token,
                                                          card: .init(securityCode: requisites.cvc),
                                                          billingAddress: data.cardAccount.billingAddress),
                                       customer: data.customer,
                                       returnUrls: .init(successUrl: webValidationUseCase[.success]?.absoluteString,
                                                         declineUrl: webValidationUseCase[.decline]?.absoluteString),
                                       recurringData: data.recurringData)
    }
    /**
     
     */
    func buildRecurringCardPaymentRequest(for
                                          requisites: CardPaymentRequisites,
                                                data: RecurringPaymentMethodData) -> RecurringPaymentRequest {
        return RecurringPaymentRequest(request: .init(),
                                       merchantOrder: data.merchantOrder,
                                       paymentMethod: data.paymentMethod,
                                       paymentData: data.paymentData,
                                       cardAccount: .init(card: .init(pan: requisites.cardNumber,
                                                                      holder: data.merchantName,
                                                                      securityCode: requisites.cvc,
                                                                      expiration: Card
                                        .string(from: requisites.expireDate)),
                                                          billingAddress: nil),
                                       customer: data.customer,
                                       returnUrls: .init(returnUrl: nil,
                                                         successUrl: webValidationUseCase[.success]?.absoluteString,
                                                         declineUrl: webValidationUseCase[.decline]?.absoluteString),
                                       recurringData: data.recurringData)
    }
}
