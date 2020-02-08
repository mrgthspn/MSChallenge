//
//  RecipeCellViewModel.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/6/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

protocol RecipeCellViewModel {
  var recipe: RecipeEntity { get }
  var titleText: String { get }
  var chefText: String { get }
}

extension RecipeEntity: RecipeCellViewModel {
  var recipe: RecipeEntity {
    self.getImage({_ in })
    return self
  }
  var titleText: String {
    return title
  }
  var chefText: String {
    if let safeChef = chef {
      return "by \(safeChef.name)"
    } else {
      return "Anonymous"
    }
  }
}
