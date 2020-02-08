//
//  Error.swift
//  MSChallengeTests
//
//  Created by Maria Agatha España on 2/8/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

struct ErrorInfo: Error, Decodable {
  let error: ErrorDetail
}

struct ErrorDetail: Decodable {
  let code: Int
  let info: String
}
