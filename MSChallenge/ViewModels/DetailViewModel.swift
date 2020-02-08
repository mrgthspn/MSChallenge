//
//  DetailViewModel.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/7/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

class DetailViewModel {
  let recipe: Bindable<Recipe?> = Bindable(nil)
  let tags: Bindable<String?> = Bindable(nil)
  
  init(recipe:inout Recipe) {
    recipe.description = recipe.description.replacingOccurrences(of: ". ", with: ".\n\n")
    
    if let safeChef = recipe.chef {
      recipe.chef?.name = safeChef.name
    }
    
    self.recipe.value = recipe
    
    if let safeTags = recipe.tags {
      self.tags.value = "Tags: "
      for tag in safeTags {
        self.tags.value? += tag.name
      }
    }
  }

}
