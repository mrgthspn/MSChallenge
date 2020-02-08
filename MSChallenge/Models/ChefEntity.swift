//
//  ChefEntity.swift
//  MSChallenge
//
//  Created by Maria Agatha España on 2/6/20.
//  Copyright © 2020 Maria Agatha España. All rights reserved.
//

import Contentful

class ChefEntity: Chef, EntryDecodable, FieldKeysQueryable  {
  static var contentTypeId: ContentTypeId = "chef"
  
  enum FieldKeys: String, CodingKey {
      case id, name
  }
  
  var id: String
  var updatedAt: Date?
  var createdAt: Date?
  var localeCode: String?
  
  var name: String
  
  required init(from decoder: Decoder) throws {
      let sys = try decoder.sys()
      id = sys.id
      
      let fields = try? decoder.contentfulFieldsContainer(keyedBy: FieldKeys.self)
      name = try fields?.decode(String.self, forKey: FieldKeys.name) ?? ""
  }
}
