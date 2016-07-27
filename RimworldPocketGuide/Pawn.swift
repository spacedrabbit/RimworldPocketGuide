//
//  Pawn.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/26/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

internal struct Pawn: XMLIndexerDeserializable {
  let thingClass: String
  let category: String
  let selectable: Bool
  let tickerType: String
  let useHitPoints: Bool
  let hasToolTip: Bool
//  let inspectorTabs: [String]
  
  internal struct Keys {
    static let thingClass: String = "thingClass"
    static let category: String = "category"
    static let selectable: String = "selectable"
    static let tickerType: String = "tickerType"
    static let useHitPoints: String = "useHitPoints"
    static let hasToolTips: String = "hasTooltip"
  }
  
  static func deserialize(node: XMLIndexer) throws -> Pawn {
    if let pawnRootNodes: [XMLIndexer] = try? node.byKey("Defs").children {
      for pawnLeafNode in pawnRootNodes {
        if let _ = pawnLeafNode.element?.attributes["Name"] {
          do {
            let thingClass: String = try pawnLeafNode.byKey(Keys.thingClass).value()
            let category: String = try pawnLeafNode.byKey(Keys.category).value()
            let selectable: Bool = try pawnLeafNode.byKey(Keys.selectable).value()
            let tickerType: String = try pawnLeafNode.byKey(Keys.tickerType).value()
            let useHitPoints: Bool = try pawnLeafNode.byKey(Keys.useHitPoints).value()
            let hasToolTips: Bool = try pawnLeafNode.byKey(Keys.hasToolTips).value()
            return Pawn(thingClass: thingClass, category: category, selectable: selectable, tickerType: tickerType, useHitPoints: useHitPoints, hasToolTip: hasToolTips)
          }
          catch {
             print("\(#function) threw!")
            // TODO
          }
        }
      }
    }
    throw XMLDeserializationError.NodeHasNoValue
  }
  
  
  
}