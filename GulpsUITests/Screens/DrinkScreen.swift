//
//  DrinkScreen.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

public class DrinkScreen: PageObject {

  public init() {
  }
  
  public func traitElements() -> [XCUIElement] {
    return [XCUIApplication().navigationBars.otherElements["Drink!"]]

  }
  
  public func plusButton() -> XCUIElement{
    return XCUIApplication().buttons["plus.icon"]
  }
  
  public func smallIconButton() -> XCUIElement{
    return XCUIApplication().buttons["small.icon"]
  }
  
  public func largeIconButton() -> XCUIElement {
      return XCUIApplication().buttons["large.icon"]
  }
  
  public func minusIconButton() -> XCUIElement {
    return XCUIApplication().buttons["minus.icon"]
  }
  
  public func percentageElement() -> XCUIElement {
    return XCUIApplication().staticTexts["percentage"]
  }
  
  public func percentageLabel() -> String {
    return percentageElement().label
  }
  
  public func undoGulpsAlert () -> XCUIElement {
    return XCUIApplication().staticTexts["Undo latest action?"]
  }
  
  public func undoGulpsAlertYesButton () -> XCUIElement {
    return XCUIApplication().alerts.buttons.element(boundBy: 0)
  }
  
  public func undoGulpsAlertNoButton () -> XCUIElement {
    return XCUIApplication().alerts.buttons.element(boundBy: 1)
  }

}

public func WhenUserAddsGulp(on screen: DrinkScreen, using gulpButton: XCUIElement, sizeOfGulp: Int = 10){
  WhenUserNavigate(to: screen, using: TabBar().drinkTab())
  let current = Int(screen.percentageLabel().replacingOccurrences(of: "%", with: ""))!
  WhenUserTaps(on: screen.plusButton())
  WhenUserTaps(on: gulpButton)
  XCTAssertTrue(WaitForLabelToBe("\(sizeOfGulp+current)%", for: screen.percentageElement()))
}

public func WhenUserRemovesGulp(on screen: DrinkScreen){
  WhenUserNavigate(to: screen, using: TabBar().drinkTab())
  WhenUserTaps(on: screen.minusIconButton())
  if screen.undoGulpsAlert().exists {
    WhenUserTaps(on: screen.undoGulpsAlertYesButton())
  }
  AndUserWaits(for: 2)
}

public func WhenUserReachesDailyGoal(on screen: DrinkScreen, using gulpButton: XCUIElement, sizeOfGulp: Int = 10){
  WhenUserNavigate(to: screen, using: TabBar().drinkTab())
  var percentageLabel = screen.percentageLabel()
  let currentLabel = Int(screen.percentageLabel().replacingOccurrences(of: "%", with: ""))!
  if currentLabel >= 100 {
    print("User reached daily goal!!!")
    return
  }
  repeat {
    WhenUserAddsGulp(on: screen, using: gulpButton, sizeOfGulp: sizeOfGulp)
    percentageLabel = screen.percentageLabel()
  } while percentageLabel != "100%"
  print("Gulp value is added!!!!!")
}

public func WhenUserResetsDailyGoal(on screen: DrinkScreen){
  WhenUserNavigate(to: screen, using: TabBar().drinkTab())
  var percentageLabel = screen.percentageLabel()
  repeat {
    WhenUserRemovesGulp(on: screen)
    percentageLabel = screen.percentageLabel()
    AndUserWaits(for: 1)
  } while percentageLabel != "0%"
  print("Gulp value is reset!!!!!")
}


