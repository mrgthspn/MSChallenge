//
//  APIService.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/5/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import Contentful

class APIService {

  private var accessToken: String = {
    guard let _contentfulConfig = Bundle.main.object(forInfoDictionaryKey: "Contentful") as? [String: String],
    let _accessKey = _contentfulConfig["Key"] else {
      fatalError("No token found.")
    }
    return _accessKey
  }()
  
  private let client: Client
  
  init() {
    client = Client(spaceId: API.spaceId, accessToken: self.accessToken, contentTypeClasses: [RecipeEntity.self, ChefEntity.self, TagEntity.self])
  }

  func fetchRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
      fetchArray(of: RecipeEntity.self) { (items, error) in
          completion(items, error)
      }
  }
  
  private func fetchArray<T: EntryDecodable & FieldKeysQueryable>(of type: T.Type, _ completion: @escaping (_ items: [T]?, _ error: Error?) -> Void) {
    
    client.fetchArray(of: T.self) { (result) in
        switch result {
        case .success(let entriesArrayResponse):
          DispatchQueue.main.async {
            completion(entriesArrayResponse.items, nil)
          }
        case .error(let error):
          DispatchQueue.main.async {
            completion(nil, error)
          }
        }
    }
    
  }
}
