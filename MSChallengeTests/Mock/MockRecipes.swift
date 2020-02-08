//
//  MockRecipes.swift
//  MSChallengeTests
//
//  Created by Maria Agatha España on 2/8/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

@testable import MSChallenge
import UIKit


extension RecipeEntity {
  
  static func with(recipes: [RecipeEntity] = [RecipeEntity(id: "test", title: "Mock Title", description: "Lorem ipsum dolor.")]) -> [Recipe] {
    return recipes
  }

  static func none(recipes: [RecipeEntity] = []) -> [Recipe] {
    return []
  }
  
}
