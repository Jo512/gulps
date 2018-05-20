//
//  PreferencesScreen.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public class PreferencesScreen: PageObject {
  
  public init() {
  }
  
  public func traitElements() -> [XCUIElement] {
    return [XCUIApplication().navigationBars.otherElements["Preferences"]]
  }
  
  public func dailyGoal() -> Int {
    return Int(XCUIApplication().textFields["daily.goal.text"].value as! String)!
  }
  
  public func smallGulp() -> Float {
    return Float(XCUIApplication().textFields["small.gulp.text"].value as! String)!
  }
  
  public func bigGulp() -> Float {
    return Float(XCUIApplication().textFields["big.gulp.text"].value as! String)!
  }
  
}

