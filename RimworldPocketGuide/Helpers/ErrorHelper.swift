//
//  ErrorHelper.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/21/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

// I don't like this overload, but it's fine for now
extension Bool {
  init(_ withString: String) {
    if withString.lowercaseString == "true" {
      self = true
    } else {
      self = false
    }
  }
}

internal class ErrorHelper {
  
  internal static func handle(error: XMLDeserializationError) {
    switch  error {
    case .NodeHasNoValue:
      print("Node has no value: \(XMLDeserializationError.NodeHasNoValue.description)")
    default:
      print("Unknown error encountered")
    }
  }
  
}
