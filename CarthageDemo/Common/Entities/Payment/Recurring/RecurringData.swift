//
//  RecurringData.swift
//  UnlimintSDK-Core
//
//  Created by Mohammad Parvez on 25/09/23.
//

import Foundation

public struct RecurringData: Codable {
    private enum CodingKeys: String, CodingKey {
        case amount
        case contractNumber = "contract_number"
        case currency
        case initiator
        case scheduledType = "scheduled_type"
        case transType = "trans_type"
        case initialAmount = "initial_amount"
        case subscriptionStart = "subscription_start"
        case plan
    }
    
    public let amount: Decimal?

    public let currency: String?
    public let contractNumber: String
    public let initiator: String = "cit"

    public var scheduledType: String = UnlimitCore.shared.recurringScheduledType
    public let transType: String
    public let initialAmount: Decimal?

    public let subscriptionStart: String?
    public let plan: RecurringPlan?
    /**
     Initializer
     */
    public init(amount: Decimal?,
                currency: String?,
                contractNumber: String,
                transType: String,
                initialAmount: Decimal?,
                subscriptionStart: String?,
                plan: RecurringPlan?) {
        self.amount = amount
        self.currency = currency
        self.contractNumber = contractNumber
        self.transType = transType
        self.initialAmount = initialAmount
        self.subscriptionStart = subscriptionStart
        self.plan = plan
    }
}




//public struct RecurringData: Codable {
//    private enum CodingKeys: String, CodingKey {
//        case amount
//        case contractNumber = "contract_number"
//        case currency
//        case initiator
//        case scheduledType = "scheduled_type"
//        case transType = "trans_type"
//    }
//    
//    public let amount: Decimal?
//
//    public let currency: String?
//    public let contractNumber: String
//    public let initiator: String
//
//    public let scheduledType: String
//    public let transType: String
//    /**
//     Initializer
//     */
//    public init(amount: Decimal?,
//                currency: String?,
//                contractNumber: String,
//                scheduledType: String,
//                transType: String) {
//        self.amount = amount
//        self.currency = currency
//        self.contractNumber = contractNumber
//        //self.initiator = initiator
//        self.scheduledType = scheduledType
//        self.transType = transType
//        self.initiator = "cit"
//    }
//}
