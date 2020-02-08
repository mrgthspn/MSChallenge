//
//  AlertShowable.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit

protocol AlertShowable {
  func toast(title: String?, message: String?, animated: Bool, actions: [UIAlertAction])
}

extension AlertShowable where Self: UIViewController {
  func toast(title: String?, message: String?, animated: Bool = true, actions: [UIAlertAction]) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions.forEach {
      alert.addAction($0)
    }
    present(alert, animated: animated)
  }
}
