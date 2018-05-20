//
//  MyProgressScreenTests.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 19/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import XCTest

class MyProgressScreenTests: BaseUITestCase {
  
  let tabBar = TabBar()
  let drinkScreen = DrinkScreen()
  let preferencesScreen = PreferencesScreen()
  let myProgressScreen = MyProgressScreen()
  let smallGulp = 10
  let largeGulp = 25
  
  func testUserAddsGulpToUpDailyGoalUsingSmallGulpInMyProgressScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulpInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.smallGulpButton(), sizeOfGulp: smallGulp)
    XCTAssertTrue(WaitForLabelToBe("10%", for: myProgressScreen.dailyGoalElement()))
    WhenUserNavigate(to: myProgressScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("10%", for: drinkScreen.percentageElement()))
  }
  
  func testUserAddsGulpToUpDailyGoalUsingLargeGulpInMyProgressScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulpInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.largeGulpButton(), sizeOfGulp: largeGulp)
    XCTAssertTrue(WaitForLabelToBe("25%", for: myProgressScreen.dailyGoalElement()))
    WhenUserNavigate(to: myProgressScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("25%", for: drinkScreen.percentageElement()))
  }
  
  func testUserReachesDailyGoalUsingSmallGulpInCalendarScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserReachesGoalInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.smallGulpButton())
    XCTAssertTrue(WaitForLabelToBe("100%", for: myProgressScreen.dailyGoalElement()))
    WhenUserNavigate(to: drinkScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("100%", for: drinkScreen.percentageElement()))
  }
  
  func testUserReachesDailyGoalUsingLargeGulpInCalendarScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserReachesGoalInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.largeGulpButton(), using: largeGulp)
    XCTAssertEqual("Goal Met!", myProgressScreen.dailyGoalLabel())
    WhenUserNavigate(to: drinkScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("100%", for: drinkScreen.percentageElement()))
  }
  
  /* Below tests verifies undo actions based on goal acheived percentage
   */
  
  func testUndoSmallGulpInDrinkScreenUpdatesMyProgressScreen(){
    var percentageLabel = drinkScreen.percentageLabel()
    if percentageLabel == "0%"
    {
      WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.smallIconButton())
      percentageLabel = drinkScreen.percentageLabel()
    }
    WhenUserRemovesGulp(on: drinkScreen)
    percentageLabel = drinkScreen.percentageLabel()
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertEqual(percentageLabel, myProgressScreen.dailyGoalLabel())
  }
  
  func testUndoLargeGulpInDrinkScreenUpdatesMyProgressScreen(){
    var percentageLabel = drinkScreen.percentageLabel()
    if percentageLabel == "0%"
    {
      WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.largeIconButton())
      percentageLabel = drinkScreen.percentageLabel()
    }
    WhenUserRemovesGulp(on: drinkScreen)
    percentageLabel = drinkScreen.percentageLabel()
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertEqual(percentageLabel, myProgressScreen.dailyGoalLabel())
  }
  
  func testUndoActionIsNotAppliedToCalendarScreenWhenUserDailyGoalIsMoreThan100Percent(){
    WhenUserReachesDailyGoal(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: largeGulp)
    WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: largeGulp)
    //progress bar should have it as Goal Met!
    WhenUserRemovesGulp(on: drinkScreen)
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertEqual("Goal Met!", myProgressScreen.dailyGoalLabel())
  }
  
  func testUndoActionIsAppliedToCalendarScreenWhenUserDailyGoalIsLessThan100Percent(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: largeGulp)
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    let progressGoalLabel = myProgressScreen.dailyGoalLabel()
    WhenUserRemovesGulp(on: drinkScreen)
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    let newProgressGoalLabel = myProgressScreen.dailyGoalLabel()
    XCTAssertLessThan(newProgressGoalLabel, progressGoalLabel)
  }
  
  func testCalendarScreenIsNotUpdatedAfterGoalMet(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserReachesDailyGoal(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: largeGulp)
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertEqual("Goal Met!", myProgressScreen.dailyGoalLabel())
    WhenUserAddsGulpInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.largeGulpButton(), sizeOfGulp: largeGulp)
    XCTAssertEqual("Goal Met!", myProgressScreen.dailyGoalLabel())
    WhenUserNavigate(to: drinkScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("125%", for: drinkScreen.percentageElement()))
  }
  
  
}

