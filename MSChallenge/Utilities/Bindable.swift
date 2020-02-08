//
//  Bindable.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

final class Bindable<T> {
  typealias Observer = ((T) -> Void)
  var observer: Observer?

  var value: T {
    didSet {
      observer?(value)
    }
  }

  init(_ observed: T) {
    self.value = observed
  }

  func bind(_ observer: Observer?) {
    self.observer = observer
    observer?(value)
  }
}
