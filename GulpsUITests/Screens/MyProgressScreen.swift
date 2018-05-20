//
//  MyProgressScreen.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public class MyProgressScreen: PageObject {
  
  public init() {
  }
  
  public func traitElements() -> [XCUIElement] {
    return [XCUIApplication().navigationBars.otherElements["My progress"]]
  }
  
  public func dailyGoalElement() -> XCUIElement  {
    return XCUIApplication().staticTexts["daily.goal"]
  }
  
  public func dailyGoalLabel() -> String  {
    return dailyGoalElement().label
  }
  
  public func tinyButton() ->  XCUIElement {
    return XCUIApplication().buttons["tiny.add"]
  }
  
  public func smallGulpButton() -> XCUIElement {
    return XCUIApplication().staticTexts["Small Gulp"]
  }
  
  public func largeGulpButton() -> XCUIElement {
    return XCUIApplication().staticTexts["Big Gulp"]
  }
  
}

public func WhenUserAddsGulpInMyProgressScreen(on screen: MyProgressScreen, using gulpButton: XCUIElement, sizeOfGulp: Int = 10){
  WhenUserNavigate(to: screen, using: TabBar().myProgressTab())
  WhenUserTaps(on: screen.tinyButton())
  WhenUserTaps(on: gulpButton)
}

public func WhenUserReachesGoalInMyProgressScreen(on screen: MyProgressScreen, using gulpButton: XCUIElement, using sizeOfGulp: Int = 10){
  WhenUserNavigate(to: screen, using: TabBar().myProgressTab())
  var dailyGoalLabel = screen.dailyGoalLabel()
  if dailyGoalLabel == "100%" { return}
  if dailyGoalLabel == "Goal Met!" {return}
  repeat {
    WhenUserAddsGulpInMyProgressScreen(on: screen, using: gulpButton, sizeOfGulp: sizeOfGulp)
    dailyGoalLabel = screen.dailyGoalLabel()
    } while dailyGoalLabel != "100%" && dailyGoalLabel != "Goal Met!"
    print("Gulp value is added!!!!!")
}


