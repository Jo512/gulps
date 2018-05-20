//
//  TabBar.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public class TabBar {
  
  public init() {
  }
  
  /* For elements that I couldn't identify in story boards to set identifiers,
   I've used indexes. In an ideal scenario, we need to be setting accessibility identifiers
   in view controllers or in story boards
   */
  
  public func drinkTab() -> XCUIElement {
    return XCUIApplication().tabBars.buttons.element(boundBy: 0)
  }
  
  public func myProgressTab() -> XCUIElement {
    return XCUIApplication().tabBars.buttons.element(boundBy: 1)
  }
  
  public func preferencesTab() -> XCUIElement {
    return XCUIApplication().tabBars.buttons.element(boundBy: 2)
  }
}



