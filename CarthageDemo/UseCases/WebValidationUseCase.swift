//
//  WebValidationUseCase.swift
//  UnlimintSDK-Core
//
//  Created by Denis Gnezdilov on 30.04.2021.
//

import Foundation

class WebValidationUseCase {

    // MARK: Private properties

    private let results: [URL: WebNavigationResults]

    // MARK: Init & Override

    init(results: [URL: WebNavigationResults]) {
        self.results = results
    }
}

// MARK: Utils

extension WebValidationUseCase {
    subscript(index: WebNavigationResults) -> URL? {
        results.first(where: { $0.value == index})?.key
    }

    subscript(index: URL) -> WebNavigationResults? {
        results.first(where: { $0.key == index})?.value
    }
}
