//
//  BindableTests.swift
//  MSChallengeTests
//
//  Created by Maria Agatha España on 2/8/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import XCTest
@testable import MSChallenge

class BindableTests: XCTestCase {
  func testBind() {
   let bindable = Bindable(true)

   let expectListenerCalled = expectation(description: "Observer")
   bindable.bind { value in
       XCTAssert(value == true, "Bind failed")
       expectListenerCalled.fulfill()
   }

   waitForExpectations(timeout: 0.1, handler: nil)
  }
}

