//
//  Actions.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 18/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public func WhenUserTaps(on element: XCUIElement) {
  if WaitForElementExists(element) {
    element.tap()
  } else {
    XCTFail("Can't Tap on \(element.debugDescription). Element is not found")
  }
}

public func WhenUserNavigate(to toScreen: PageObject, using element: XCUIElement, timeout: Double = 10.0){
  if !isUserOnScreen(toScreen, timeout: 1) {
    WhenUserTaps(on: element)
    ThenUserShouldBeOnScreen(toScreen, timeout: timeout)
  }
}

