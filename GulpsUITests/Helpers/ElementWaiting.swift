//
//  ElementWaiting.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public func WaitForElementExists(_ element: XCUIElement, timeout: Double = 10.0) -> Bool {
  let expectations = [XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: element)]
  let result = XCTWaiter().wait(for: expectations, timeout: timeout)
  return result == .completed
}

public func WaitForLabelToBe(_ text: String, `for` element: XCUIElement, timeout: Double = 10.0) -> Bool {
  let expectations = [XCTNSPredicateExpectation(predicate: NSPredicate(format: "label ==[c] '\(text)'"), object: element)]
  let result = XCTWaiter().wait(for: expectations, timeout: timeout)
  return result == .completed
}
