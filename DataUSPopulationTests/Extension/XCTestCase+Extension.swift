//
//  XCTestCase+Extension.swift
//  DataUSPopulationTests
//
//  Created by Masam Mahmood on 25/10/2024.
//

import XCTest
import Combine

extension XCTestCase {
    typealias CompetionResult = (expectation: XCTestExpectation,
                                 cancellable: AnyCancellable)
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   expectationDescription: String,
                                   equals: [(T.Output) -> Bool])
    -> CompetionResult {
        let exp = expectation(description: expectationDescription)
        var mutableEquals = equals
        let cancellable = publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                if mutableEquals.first?(value) ?? false {
                    _ = mutableEquals.remove(at: 0)
                    if mutableEquals.isEmpty {
                        exp.fulfill()
                    }
                }
            })
        return (exp, cancellable)
    }
}
