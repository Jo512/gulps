//
//  ElementAssertions.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest


public func AndUserWaits(for timeout: UInt32 = 1) {
  sleep(timeout)
}

public func isUserOnScreen(_ screen: PageObject, timeout: Double = 10.0) -> Bool {
  var isOnScreen = true
  for element in screen.traitElements() {
    isOnScreen = isOnScreen && WaitForElementExists(element, timeout: timeout)
  }
  return isOnScreen
}

public func ThenUserShouldBeOnScreen(_ screen: PageObject, timeout: Double = 10.0, file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(isUserOnScreen(screen, timeout: timeout), "Expected to be on \(type(of: screen))", file: file, line: line)
}
