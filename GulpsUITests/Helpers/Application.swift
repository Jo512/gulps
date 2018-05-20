//
//  Application.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 18/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import Foundation
import XCTest

internal let defaultTimeout: Double = 10.0

open class Application {
  
  public private(set) var xcApp: XCUIApplication
  
  internal var defaultScreen: PageObject!
  
  init() {
    self.xcApp = XCUIApplication()
  }
  
}

