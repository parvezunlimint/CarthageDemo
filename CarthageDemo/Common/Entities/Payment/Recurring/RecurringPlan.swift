//
//  RecurringPlan.swift
//  UnlimintSDK-Core
//
//  Created by Mohammad Parvez on 25/09/23.
//

import Foundation


public struct RecurringPlan: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
    
    public var id : String
    
    public init(id: String) {
        self.id = id
    }
}
