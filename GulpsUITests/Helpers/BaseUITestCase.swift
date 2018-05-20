//
//  BaseUITestCase.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 18/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import XCTest

class BaseUITestCase: XCTestCase {
  
  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    XCUIApplication().launch()
    skipOnBoarding()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func skipOnBoarding(){
    let onBoardingScreen = OnBoardingScreen()
    let drinkScreen = DrinkScreen()
    if isUserOnScreen(onBoardingScreen, timeout:2) {
      repeat {
        WhenUserTaps(on: onBoardingScreen.nextButton())
      } while !isUserOnScreen(drinkScreen, timeout:2)
    }
  }
}
