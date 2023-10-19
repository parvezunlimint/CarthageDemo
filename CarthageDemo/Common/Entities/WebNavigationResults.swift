//
//  Authorization3dResult.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 30.11.2020.
//

import Foundation

/**
 * Result of checking redirect url of WebView
 **/
@frozen
public enum WebNavigationResults {
    /**
     * Web operation successfully passed
     */
    case success

    /**
     * Web operation is declined
     */
    case decline

    /**
     * Security error. url is invalid. Web flow should be closed with error
     */
    case invalid

    /**
     * Load this url
     */
    case skip
}
