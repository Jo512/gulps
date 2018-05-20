//
//  PageObject.swift
//  GulpsUITests
//
//  Created by Jo Amarlapudi on 18/05/2018.
//  Copyright © 2018 Fancy Pixel. All rights reserved.
//

import XCTest
public protocol PageObject {
  
  func traitElements() -> [XCUIElement]
}

