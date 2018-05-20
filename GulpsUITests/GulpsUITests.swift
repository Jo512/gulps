//
//  GulpsUITests.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 17/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import XCTest

class GulpsUITests: BaseUITestCase {
        
  let tabBar = TabBar()
  let drinkScreen = DrinkScreen()
  let preferencesScreen = PreferencesScreen()
  let myProgressScreen = MyProgressScreen()
  let smallGulp = 10
  let largeGulp = 25
  
  
  func testUserAddsGulpToUpDailyGoalUsingSmallGulpInDrinkScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.smallIconButton(), sizeOfGulp: smallGulp)
    XCTAssertTrue(WaitForLabelToBe("10%", for: drinkScreen.percentageElement()))
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertTrue(WaitForLabelToBe("10%", for: myProgressScreen.dailyGoalElement()))
  }
  
  func testUserAddsGulpToUpDailyGoalUsingLargeGulpInDrinkScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: largeGulp)
    XCTAssertTrue(WaitForLabelToBe("25%", for: drinkScreen.percentageElement()))
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertTrue(WaitForLabelToBe("25%", for: myProgressScreen.dailyGoalElement()))
  }
  
  func testUserAddsGulpToUpDailyGoalUsingSmallGulpInMyProgressScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulpInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.smallGulpButton(), sizeOfGulp: smallGulp)
    XCTAssertTrue(WaitForLabelToBe("10%", for: myProgressScreen.dailyGoalElement()))
    WhenUserNavigate(to: drinkScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("10%", for: drinkScreen.percentageElement()))
  }
  
  func testUserAddsGulpToUpDailyGoalUsingLargeGulpInMyProgressScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserAddsGulpInMyProgressScreen(on: myProgressScreen, using: myProgressScreen.largeGulpButton(), sizeOfGulp: largeGulp)
    XCTAssertTrue(WaitForLabelToBe("25%", for: myProgressScreen.dailyGoalElement()))
    WhenUserNavigate(to: drinkScreen, using: tabBar.drinkTab())
    XCTAssertTrue(WaitForLabelToBe("25%", for: drinkScreen.percentageElement()))
  }
  
  /* Bewlow 4 tests verify if user has existing gulp, if user has existing gulp then resets the gulp
   and then adds gulp to reach goal */
  func testUserReachesDailyGoalUsingSmallGulpInDrinkScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserReachesDailyGoal(on: drinkScreen, using: drinkScreen.smallIconButton())
    XCTAssertTrue(WaitForLabelToBe("100%", for: drinkScreen.percentageElement()))
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertTrue(WaitForLabelToBe("100%", for: myProgressScreen.dailyGoalElement()))
  }
  
  func testUserReachesDailyGoalUsingLargeGulpInDrinkScreen(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    WhenUserReachesDailyGoal(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: largeGulp)
    XCTAssertTrue(WaitForLabelToBe("100%", for: drinkScreen.percentageElement()))
    WhenUserNavigate(to: myProgressScreen, using: tabBar.myProgressTab())
    XCTAssertTrue(WaitForLabelToBe("Goal Met!", for: myProgressScreen.dailyGoalElement()))
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
  
  func testUserIsAbleToUndoPreviousAction(){
    WhenUserResetsDailyGoal(on: drinkScreen)
    var gulpActions = [smallGulp, largeGulp]
    WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.smallIconButton(), sizeOfGulp: gulpActions[0])
    WhenUserAddsGulp(on: drinkScreen, using: drinkScreen.largeIconButton(), sizeOfGulp: gulpActions[1])
    WhenUserRemovesGulp(on: drinkScreen)
    XCTAssertTrue(WaitForLabelToBe("10%", for: drinkScreen.percentageElement()))
    WhenUserRemovesGulp(on: drinkScreen)
    XCTAssertTrue(WaitForLabelToBe("0%", for: drinkScreen.percentageElement()))
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

/*
  Couple of Improvements -
 
 1. Currently when user reaches daily goal using small gulp in drink screen or calendar screen, "Goal Met!" is not shown when goal is 100%. If user tries to enter gulp again, thats when "Goal Met!" is shown in calendar screen.
 
 However when user reaches daily goal using large gulp, then "Goal Met!" is shown when goal reaches 100%.
 
 Due this inconsistency, I've asserted "100%" and "Goal Met!" for small gul and large gulp.

 
 2. User is able to add gulps in calendar screen, howeever there is no undo action in calendar screen. User has to navigate to drink screen to undo previous action
 
 */

