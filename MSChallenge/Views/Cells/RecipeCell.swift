//
//  RecipeCell.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/6/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
  var viewModel: RecipeCellViewModel? {
    didSet {
      bindViewModel()
    }
  }
  
  @IBOutlet weak var recipeImageView: UIImageView!
  @IBOutlet weak var recipeTitleLabel: UILabel!
  @IBOutlet weak var recipeChefLabel: UILabel!
  
  private func bindViewModel() {
    guard let viewModel = viewModel else {
      return
    }
    recipeTitleLabel.text = viewModel.titleText
    recipeChefLabel.text = viewModel.chefText
    viewModel.recipe.getImage({ [weak self] image in
      self?.recipeImageView.image = image
    })
  }
    
}

