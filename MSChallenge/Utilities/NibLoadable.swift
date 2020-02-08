//
//  NibLoadable.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import UIKit
protocol NibLoadable {
  static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
  static var nib: UINib {
    let className = String(describing: self)
    return UINib(nibName: className, bundle: Bundle(for: self))
  }
}
