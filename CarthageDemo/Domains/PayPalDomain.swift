//
//  PayPalDomain.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 21.04.2021.
//

import Foundation

/**
 Payment with PayPal

 Payment flow consists of 3 consecutive steps:

 - pay(data: PaypalPaymentMethodData, completion: @escaping PayPalClosure) - send email data and another PayPaL data
 - show WebView with redirectUrl from first step
 - onUserNavigateTo(url: URL) - Check result of payment operation by redirect url from webView
 */
public class PayPalDomain {

    /// Completion closure for PayPal method
    public typealias PayPalClosure = (Result<PaypalResultModel, UnlimintErrors>) -> Void

    // MARK: Private properties

    private let mobieToken: String
    private let requestUseCase: PayPalRequestUseCaseProtocol = PayPalRequestUseCase()
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

public extension PayPalDomain {

    /**

     - parameter data: PayPal requisites
     - parameter completion: Callback of result payment request
     - warning: Completion closure does not guarantee the result will be returned on the main queue.

     */
    func pay(data: PaypalPaymentMethodData,
             completion: @escaping PayPalClosure) {
        let request: PaypalPaymentRequest = .init(request: .init(),
                                                  merchantOrder: data.merchantOrder,
                                                  paymentMethod: data.paymentMethod,
                                                  paymentData: .init(amount: data.paymentData.amount,
                                                                     currency: data.paymentData.currency,
                                                                     note: data.paymentData.note,
                                                                     dynamicDescriptor: data
                                                                        .paymentData
                                                                        .dynamicDescriptor,
                                                                     transType: data.paymentData.transType),
                                                  customer: data.customer,
                                                  returnUrls:
                                                    .init(returnUrl: nil,
                                                          successUrl: webValidationUseCase[.success]?.absoluteString,
                                                          declineUrl: webValidationUseCase[.decline]?.absoluteString))

        requestUseCase.pay(request: (mobieToken, request)) { [weak self] result in
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

    /**
     Check result of operation by redirect url from webView.

     - parameter url: URL by which the redirect to the webView occurs.
     - returns: WebNavigationResult: URL verification result

     */
    func onUserNavigateTo(url: URL) -> WebNavigationResults {
        webValidationUseCase[url] ?? .skip
    }
}
