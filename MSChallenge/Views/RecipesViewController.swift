//
//  RecipesViewController.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit

class RecipesViewController: UITableViewController {
  
  let viewModel: RecipesViewModel = RecipesViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refreshControl = UIRefreshControl()
    viewModel.getRecipes()
    tableSettings()
    bindViewModel()
  }
  
  func tableSettings() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(RecipeCell.self)
    tableView.accessibilityIdentifier = "RecipeTable"
    if let safeRefreshControl = refreshControl {
      safeRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        safeRefreshControl.addTarget(self, action: #selector(RecipesViewController.refresh(sender:)), for: UIControl.Event.valueChanged)
      tableView.addSubview(safeRefreshControl)
    }
  }
  
  func bindViewModel() {
    viewModel.recipeCells.bind() { [weak self] _ in
      if let `self` = self {
        self.tableView.reloadData()
      }
    }
    
    viewModel.error.bind() { [weak self] error in
      if let `self` = self, let safeError = error {
        self.toast(title: "Error", message: safeError.localizedDescription, actions: [UIAlertAction(title: "Ok", style: .default, handler: nil)])
      }
    }
  }
  
  @objc func refresh(sender: AnyObject) {
    viewModel.getRecipes()
    if let safeRefreshControl = refreshControl {
      safeRefreshControl.endRefreshing()
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.recipeCells.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeue(RecipeCell.self) else {
       return UITableViewCell()
     }
     cell.viewModel = viewModel.recipeCells.value[indexPath.row]
     return cell
   }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailViewModel = viewModel.getRecipeDetailModel(indexPath.row)
    let detailedView = self.storyboard?.instantiateViewController(withIdentifier: "DetailedRecipe") as! DetailViewController
    detailedView.viewModel = detailViewModel
      self.navigationController?.pushViewController(detailedView, animated: true)
    }
      
  
}

extension RecipesViewController: AlertShowable {}
