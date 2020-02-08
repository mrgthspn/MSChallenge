//
//  Recipe.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/6/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit

protocol Recipe: Base {
  var title: String { get set }
  var description: String { get set }
  var chef: Chef? { get set }
  var tags: [Tag]? { get set }
  
  func getImage(_ completion: @escaping (_ image: UIImage) -> Void)
}
