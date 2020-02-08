//
//  RecipesViewModel.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/6/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

class RecipesViewModel {
  
  let apiService: APIService
  let recipeCells = Bindable([RecipeCellViewModel]())
  
  lazy var error: Bindable<Error?> = Bindable(nil)
  
  lazy var recipes = [Recipe]()
  
  init(apiService: APIService = APIService()) {
    self.apiService = apiService
  }
  
  func getRecipes() {
    apiService.fetchRecipes(completion: { [weak self] (recipes, error) in
      guard let `self` = self else {
        return
      }
      
      if let safeError = error {
        self.error.value = safeError
        return
      }
      
      if let safeRecipes = recipes {
        self.recipes = safeRecipes
        self.recipeCells.value = safeRecipes.compactMap { $0 as? RecipeCellViewModel }
      }
        
    })
  }
  
  func getRecipeDetailModel(_ index: Int) -> DetailViewModel {
    let viewModel = DetailViewModel(recipe: &recipes[index])
    return viewModel
  }
}


