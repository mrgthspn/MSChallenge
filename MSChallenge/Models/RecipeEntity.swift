//
//  RecipeEntity.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/6/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import Contentful

class RecipeEntity: Recipe, EntryDecodable, FieldKeysQueryable  {
  static var contentTypeId: ContentTypeId = "recipe"
  
  enum FieldKeys: String, CodingKey {
      case id, title, photo, description, chef, tags
  }
  
  var id: String
  var updatedAt: Date?
  var createdAt: Date?
  var localeCode: String?
  
  var title: String
  var description: String
  var chef: Chef?
  var tags: [Tag]?
  
  private var photoAsset: Asset?
  private var image: UIImage?
  
  func getImage(_ completion: @escaping (_ image: UIImage) -> Void) {
      if let image = image {
          return completion(image)
      }
      DispatchQueue.global().async {
          if let url = self.photoAsset?.url, let data = try? Data(contentsOf: url) {
              guard let image = UIImage(data: data) else {
                  return
              }
              self.image = image
              DispatchQueue.main.async {
                  completion(image)
              }
          }
      }
  }
  
  required init(from decoder: Decoder) throws {
      let sys = try decoder.sys()
      id = sys.id
      
      let fields = try? decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
      title = try fields?.decode(String.self, forKey: FieldKeys.title) ?? ""
      description = try fields?.decode(String.self, forKey: FieldKeys.description) ?? ""
      
      try? fields?.resolveLink(forKey: FieldKeys.photo, decoder: decoder) { (object) in
          self.photoAsset = (object as? Asset)
      }
      try? fields?.resolveLink(forKey: FieldKeys.chef, decoder: decoder) { (object) in
          self.chef = object as? Chef
      }
      try? fields?.resolveLinksArray(forKey: FieldKeys.tags, decoder: decoder, callback: { (object) in
          self.tags = object as? [Tag]
      })
  }
  
  init(id: String, title: String, description: String) {
    self.id = id
    self.title = title
    self.description = description
  }
}
