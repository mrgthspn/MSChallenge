//
//  RecipesViewModelTests.swift
//  MSChallengeTests
//
//  Created by Maria Agatha España on 2/8/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import XCTest
@testable import MSChallenge

class RecipesViewModelTests: XCTestCase {

// MARK: - bindableCells
  func testNormalCells() {
    let appServerClient = MockAppServerClient()
    appServerClient.setMockObject(RecipeEntity.with())
    let viewModel = RecipesViewModel(apiService: appServerClient)
    viewModel.getRecipes()
    guard viewModel.recipeCells.value.first != nil else {
         XCTFail()
         return
    }
  }
    
    
  func testEmptyCells() {
   let appServerClient = MockAppServerClient()
    appServerClient.setMockObject(RecipeEntity.none())
    let viewModel = RecipesViewModel(apiService: appServerClient)
    viewModel.getRecipes()
    guard viewModel.recipeCells.value.first != nil else {
         XCTAssert(true)
         return
    }
    XCTFail()
  }

  func testErrorNotFoundCells() {
    let appServerClient = MockAppServerClient()
    appServerClient.setMockObject(nil)
    let viewModel = RecipesViewModel(apiService: appServerClient)
    viewModel.getRecipes()
    
    if viewModel.error.value != nil {
      XCTAssert(true)
    } else {
      XCTFail()
    }
  }
  
}

private final class MockAppServerClient: APIService {
  
  var recipe: [Recipe]?
  
  override func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
    if recipe == nil {
      completion(nil, ErrorInfo(error: ErrorDetail(code: -99, info: "Testing error message")))
    } else {
      completion(recipe, nil)
    }
  }
  
  func setMockObject(_ recipe: [Recipe]?) {
    self.recipe = recipe
  }
}
