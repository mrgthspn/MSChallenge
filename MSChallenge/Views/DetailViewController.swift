//
//  DetailViewController.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var viewModel: DetailViewModel?
  
  @IBOutlet weak var recipeImageView: UIImageView!
  @IBOutlet weak var recipeTitle: UILabel!
  @IBOutlet weak var recipeChef: UILabel!
  @IBOutlet weak var recipeTags: UILabel!
  @IBOutlet weak var recipeDescription: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    self.navigationItem.title = "Instructions"
  }
  
  private func bindViewModel() {
    viewModel?.recipe.bind() { [weak self] recipe in
      recipe?.getImage({ [weak self] image in
        if let `self` = self {
          self.recipeImageView.image = image
        }
      })
      guard let `self` = self, let safeRecipe = recipe else {
        return
      }
      self.recipeTitle.text = safeRecipe.title
      if let safeChef = safeRecipe.chef {
        self.recipeChef.text = safeChef.name
      } 
      self.recipeDescription.text  = safeRecipe.description
    }
    
    viewModel?.tags.bind() { [weak self] tags in
      guard let `self` = self else {
        return
      }
      self.recipeTags.text = tags
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    scrollView.updateContentView()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)
      coordinator.animate(alongsideTransition: nil) { _ in
        self.scrollView.updateContentView()
      }
  }
  
}

private extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height + 10
    }
}
