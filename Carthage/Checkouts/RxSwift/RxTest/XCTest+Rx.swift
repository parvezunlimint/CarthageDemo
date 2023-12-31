//
//  XCTest+Rx.swift
//  RxTest
//
//  Created by Krunoslav Zaher on 12/19/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if !os(watchOS)
import RxSwift
import XCTest
/**
Asserts two lists of events are equal.

Event is considered equal if:
* `Next` events are equal if they have equal corresponding elements.
* `Error` events are equal if errors have same domain and code for `NSError` representation and have equal descriptions.
* `Completed` events are always equal.

- parameter lhs: first set of events.
- parameter rhs: second set of events.
- parameter file: The path to the file in which it appears.
- parameter line: The line number on which it appears.
*/
public func XCTAssertEqual<Element: Equatable>(_ lhs: [Event<Element>], _ rhs: [Event<Element>], file: StaticString = #file, line: UInt = #line) {
    let leftEquatable = lhs.map { AnyEquatable(target: $0, comparer: ==) }
    let rightEquatable = rhs.map { AnyEquatable(target: $0, comparer: ==) }
    #if os(Linux)
      XCTAssertEqual(leftEquatable, rightEquatable)
    #else
      XCTAssertEqual(leftEquatable, rightEquatable, file: file, line: line)
    #endif
    if leftEquatable == rightEquatable {
        return
    }

    printSequenceDifferences(lhs, rhs, ==)
}

/**
 Asserts two lists of events are equal.

 Event is considered equal if:
 * `Next` events are equal if they have equal corresponding elements.
 * `Error` events are equal if errors have same domain and code for `NSError` representation and have equal descriptions.
 * `Completed` events are always equal.

 - parameter lhs: first set of events.
 - parameter rhs: second set of events.
 - parameter file: The path to the file in which it appears.
 - parameter line: The line number on which it appears.
 */
public func XCTAssertEqual<Element: Equatable>(_ lhs: [SingleEvent<Element>], _ rhs: [SingleEvent<Element>], file: StaticString = #file, line: UInt = #line) {
    let leftEquatable = lhs.map { AnyEquatable(target: $0, comparer: equals) }
    let rightEquatable = rhs.map { AnyEquatable(target: $0, comparer: equals) }
    #if os(Linux)
        XCTAssertEqual(leftEquatable, rightEquatable)
    #else
        XCTAssertEqual(leftEquatable, rightEquatable, file: file, line: line)
    #endif
    if leftEquatable == rightEquatable {
        return
    }

    printSequenceDifferences(lhs, rhs, equals)
}

/**
 Asserts two lists of events are equal.

 Event is considered equal if:
 * `Next` events are equal if they have equal corresponding elements.
 * `Error` events are equal if errors have same domain and code for `NSError` representation and have equal descriptions.
 * `Completed` events are always equal.

 - parameter lhs: first set of events.
 - parameter rhs: second set of events.
 - parameter file: The path to the file in which it appears.
 - parameter line: The line number on which it appears.
 */
public func XCTAssertEqual<Element: Equatable>(_ lhs: [MaybeEvent<Element>], _ rhs: [MaybeEvent<Element>], file: StaticString = #file, line: UInt = #line) {
    let leftEquatable = lhs.map { AnyEquatable(target: $0, comparer: ==) }
    let rightEquatable = rhs.map { AnyEquatable(target: $0, comparer: ==) }
    #if os(Linux)
        XCTAssertEqual(leftEquatable, rightEquatable)
    #else
        XCTAssertEqual(leftEquatable, rightEquatable, file: file, line: line)
    #endif
    if leftEquatable == rightEquatable {
        return
    }

    printSequenceDifferences(lhs, rhs, ==)
}

/**
 Asserts two lists of events are equal.

 Event is considered equal if:
 * `Next` events are equal if they have equal corresponding elements.
 * `Error` events are equal if errors have same domain and code for `NSError` representation and have equal descriptions.
 * `Completed` events are always equal.

 - parameter lhs: first set of events.
 - parameter rhs: second set of events.
 - parameter file: The path to the file in which it appears.
 - parameter line: The line number on which it appears.
 */
public func XCTAssertEqual(_ lhs: [CompletableEvent], _ rhs: [CompletableEvent], file: StaticString = #file, line: UInt = #line) {
    let leftEquatable = lhs.map { AnyEquatable(target: $0, comparer: ==) }
    let rightEquatable = rhs.map { AnyEquatable(target: $0, comparer: ==) }
    #if os(Linux)
        XCTAssertEqual(leftEquatable, rightEquatable)
    #else
        XCTAssertEqual(leftEquatable, rightEquatable, file: file, line: line)
    #endif
    if leftEquatable == rightEquatable {
        return
    }

    printSequenceDifferences(lhs, rhs, ==)
}

/**
Asserts two lists of Recorded events are equal.

Recorded events are equal if times are equal and recorded events are equal.

Event is considered equal if:
* `Next` events are equal if they have equal corresponding elements.
* `Error` events are equal if errors have same domain and code for `NSError` representation and have equal descriptions.
* `Completed` events are always equal.

- parameter lhs: first set of events.
- parameter rhs: second set of events.
- parameter file: The path to the file in which it appears.
- parameter line: The line number on which it appears.
*/
public func XCTAssertEqual<Element: Equatable>(_ lhs: [Recorded<Event<Element>>], _ rhs: [Recorded<Event<Element>>], file: StaticString = #file, line: UInt = #line) {
    let leftEquatable = lhs.map { AnyEquatable(target: $0, comparer: ==) }
    let rightEquatable = rhs.map { AnyEquatable(target: $0, comparer: ==) }
    #if os(Linux)
      XCTAssertEqual(leftEquatable, rightEquatable)
    #else
      XCTAssertEqual(leftEquatable, rightEquatable, file: file, line: line)
    #endif

    if leftEquatable == rightEquatable {
        return
    }

    printSequenceDifferences(lhs, rhs, ==)
}

/**
 Asserts two lists of Recorded events with optional elements are equal.
 
 Recorded events are equal if times are equal and recorded events are equal.
 
 Event is considered equal if:
 * `Next` events are equal if they have equal corresponding elements.
 * `Error` events are equal if errors have same domain and code for `NSError` representation and have equal descriptions.
 * `Completed` events are always equal.
 
 - parameter lhs: first set of events.
 - parameter rhs: second set of events.
 - parameter file: The path to the file in which it appears.
 - parameter line: The line number on which it appears.
 */
public func XCTAssertEqual<Element: Equatable>(_ lhs: [Recorded<Event<Element?>>], _ rhs: [Recorded<Event<Element?>>], file: StaticString = #file, line: UInt = #line) {
    let leftEquatable = lhs.map { AnyEquatable(target: $0, comparer: ==) }
    let rightEquatable = rhs.map { AnyEquatable(target: $0, comparer: ==) }
    #if os(Linux)
        XCTAssertEqual(leftEquatable, rightEquatable)
    #else
        XCTAssertEqual(leftEquatable, rightEquatable, file: file, line: line)
    #endif

    if leftEquatable == rightEquatable {
        return
    }

    printSequenceDifferences(lhs, rhs, ==)
}

/**
 Assert a list of Recorded events has emitted the provided elements.
 This method does not take event times into consideration.

 This method will assert a failure if any stop events have been emitted (e.g. `completed` or `error`).

 - parameter stream: Array of recorded events.
 - parameter elements: Array of expected elements.
*/
public func XCTAssertRecordedElements<Element: Equatable>(_ stream: [Recorded<Event<Element>>], _ elements: [Element], file: StaticString = #file, line: UInt = #line) {

    if let stopEvent = stream.first(where: { $0.value.isStopEvent }) {
        #if os(Linux)
        XCTFail("A non-next stop event has been emitted: \(stopEvent)")
        #else
        XCTFail("A non-next stop event has been emitted: \(stopEvent)", file: file, line: line)
        #endif
        return
    }

    let streamElements = stream.map { event -> Element in
        guard case .next(let element) = event.value else {
            fatalError("Non-next stop event should cause assertion")
        }

        return element
    }

    #if os(Linux)
    XCTAssertEqual(streamElements, elements)
    #else
    XCTAssertEqual(streamElements, elements, file: file, line: line)
    #endif

    if streamElements == elements {
        return
    }

    printSequenceDifferences(streamElements, elements, ==)
}

func printSequenceDifferences<Element>(_ lhs: [Element], _ rhs: [Element], _ equal: (Element, Element) -> Bool) {
    print("Differences:")
    for (index, elements) in zip(lhs, rhs).enumerated() {
        let l = elements.0
        let r = elements.1
        if !equal(l, r) {
            print("lhs[\(index)]:\n    \(l)")
            print("rhs[\(index)]:\n    \(r)")
        }
    }

    let shortest = min(lhs.count, rhs.count)
    for (index, element) in lhs[shortest ..< lhs.count].enumerated() {
        print("lhs[\(index + shortest)]:\n    \(element)")
    }
    for (index, element) in rhs[shortest ..< rhs.count].enumerated() {
        print("rhs[\(index + shortest)]:\n    \(element)")
    }
}
#endif
