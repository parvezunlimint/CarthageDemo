//
//  BindingCardDomain.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 21.04.2021.
//

import Foundation

/**
 Binding bank card

 Payment flow consists of 3 consecutive steps:

 - bindCard(for requisites: CardRequisites, data: BindingMethodData, completion: @escaping BindingClosure) - send bank card data and another binding data
 - show WebView with redirectUrl from first step
 - onUserNavigateTo(url: URL) - Check result of payment operation by redirect url from webView
 */
public class BindingCardDomain {

    /// Completion closure for binding method
    public typealias BindingClosure = (Result<BindingResultModel, UnlimintErrors>) -> Void

    // MARK: Private properties

    private let mobieToken: String
    private let bindingUseCase: BindingRequestUseCaseProtocol = BindingRequestUseCase()
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

public extension BindingCardDomain {
    /**

     - parameter requisites: Binding card requisites
     - parameter data: The data required for binding.
     - parameter completion: A closure that returns the result of the map binding.
     - warning: Completion closure does not guarantee the result will be returned on the main queue.

     */
    func bindCard(for requisites: CardRequisites,
                  data: BindingMethodData,
                  completion: @escaping BindingClosure) {
                
        
        if UnlimitCore.shared.getCardBindingToken  {
            
            let request = BindingRequestToken(request: .init(),
                                         merchantOrder: data.merchantOrder,
                                         recurringData: .init(currency: data.currency.value),
                                         cardAccount: .init(card: .init(pan: requisites.cardNumber,
                                                                        holder: "MR CARDHOLDER",
                                                                        securityCode: requisites.cvc,
                                                                        expiration: Card
                                            .string(from: requisites.expireDate)),
                                                            billingAddress: data.cardAccount?.billingAddress),
                                         customer: data.customer,
                                         returnUrls: .init(successUrl: webValidationUseCase[.success]?.absoluteString,
                                                           declineUrl: webValidationUseCase[.decline]?.absoluteString))
            
            bindingUseCase.bind(request: (mobieToken, request)) { [weak self] result in
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
                    
                    completion(.success(.init(recurringId: model.recurringData.id,
                                              redirectUrl: redirectUrl)))
                    
                case let .failure(error):
                    completion(.failure(error.unlimintError()))
                }
            }
        }
        else {
            
            let request = BindingRequest(request: .init(),
                                         merchantOrder: data.merchantOrder,
                                         recurringData: .init(currency: data.currency.value),
                                         cardAccount: .init(card: .init(pan: requisites.cardNumber,
                                                                        holder: "MR CARDHOLDER",
                                                                        securityCode: requisites.cvc,
                                                                        expiration: Card
                                            .string(from: requisites.expireDate)),
                                                            billingAddress: data.cardAccount?.billingAddress),
                                         customer: data.customer,
                                         returnUrls: .init(successUrl: webValidationUseCase[.success]?.absoluteString,
                                                           declineUrl: webValidationUseCase[.decline]?.absoluteString))
            
            bindingUseCase.bind(request: (mobieToken, request)) { [weak self] result in
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
                    
                    completion(.success(.init(recurringId: model.recurringData.id,
                                              redirectUrl: redirectUrl)))
                    
                case let .failure(error):
                    completion(.failure(error.unlimintError()))
                }
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
