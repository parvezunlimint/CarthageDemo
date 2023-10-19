//
//  AnyObject+Apply.swift
//  UnlimintSDK
//
//  Created by Denis Gnezdilov on 05.03.2021.
//

import Foundation

/**
    A simple and useful utility for object configuration
 */
public protocol Apply {
}

public extension Apply {
    /**
     Use this function to configure the object inside closure
     */
    @discardableResult
    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)

        return self
    }
}

extension NSObject: Apply {
}
