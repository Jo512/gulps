//
//  OnBoardingScreen.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 18/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public class OnBoardingScreen: PageObject {
  
  public init() {
  }
  
  public func traitElements() -> [XCUIElement] {
    return [XCUIApplication().staticTexts["Hi there!"]]
  }
  
  public func nextButton() -> XCUIElement {
    return XCUIApplication().buttons["onboarding.next"]
    
  }
  
}


