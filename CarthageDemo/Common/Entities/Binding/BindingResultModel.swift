//
//  BindingResultModel.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 26.04.2021.
//

import Foundation

/**
 Binding data model
 */
public struct BindingResultModel {

    /**
     Id for recurring
     */
    public let recurringId: String

    /**
     Is url for completing operation with WebView
     */
    public let redirectUrl: URL
}
