//
//  UITableViewExtension.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit
extension UITableView {
  
  func register<T: NibLoadable & Reusable >(_ cell: T.Type) {
    register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
  }
  
  func dequeue<T: Reusable>(_ : T.Type) -> T? {
    return dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T
  }
}

