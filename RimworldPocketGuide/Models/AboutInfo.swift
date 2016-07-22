//
//  AboutInfo.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/21/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

private struct AboutKeys {
  static let topLevel: String = "ModMetaData"
  static let name: String = "name"
  static let author: String = "author"
  static let url: String = "url"
  static let description: String = "description"
}

internal struct AboutInfo: XMLIndexerDeserializable, CustomStringConvertible {
  let name: String
  let author: String
  let url: String
  let aboutDescription: String
  
  var description: String {
    return "Name: \(name)\nAuthor: \(author)\nURL: \(url)\nDescription: \(aboutDescription)"
  }
  
  static func deserialize(node: XMLIndexer) throws -> AboutInfo {
    return try AboutInfo(
      name: node[AboutKeys.topLevel][AboutKeys.name].value(),
      author: node[AboutKeys.topLevel][AboutKeys.author].value(),
      url: node[AboutKeys.topLevel][AboutKeys.url].value(),
      aboutDescription: node[AboutKeys.topLevel][AboutKeys.description].value())
  }
}