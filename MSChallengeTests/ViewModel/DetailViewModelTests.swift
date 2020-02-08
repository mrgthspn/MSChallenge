//
//  DetailViewModelTests.swift
//  MSChallengeTests
//
//  Created by Maria Agatha España on 2/8/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import XCTest
@testable import MSChallenge

class DetailViewModelTests: XCTestCase {
  
  func testDetail() {
    var mockRecipe = RecipeEntity.with()[0]
    let viewModel = DetailViewModel(recipe: &mockRecipe)
    guard viewModel.recipe.value != nil else {
         XCTFail()
         return
    }
  }
  
}


