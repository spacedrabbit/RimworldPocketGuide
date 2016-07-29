//
//  Pawn.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/26/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

protocol DatabaseMarkable {
  var className: String { get set }
  var abstractClass: Bool { get set }
  var parentClass: String? { get set }
  var subclasses: [String]? { get set }
  mutating func markForDatabase(className: String, abstractClass: Bool, parentClass: String?, subclasses: [String]?)
}


internal struct Pawn: XMLIndexerDeserializable, DatabaseMarkable {
  var thingClass: String
  var category: String
  var selectable: Bool
  var tickerType: String
  var useHitPoints: Bool
  var hasToolTip: Bool
//  let inspectorTabs: [String]
  
  var className: String = ""
  var abstractClass: Bool = false
  var parentClass: String?
  var subclasses: [String]?
  
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
        if let xmlClassName = pawnLeafNode.element?.attributes["Name"],
           xmlAbstractClass = pawnLeafNode.element?.attributes["Abstract"] {
          
          do {
            let thingClass: String = try pawnLeafNode.byKey(Keys.thingClass).value()
            let category: String = try pawnLeafNode.byKey(Keys.category).value()
            let selectable: Bool = try pawnLeafNode.byKey(Keys.selectable).value()
            let tickerType: String = try pawnLeafNode.byKey(Keys.tickerType).value()
            let useHitPoints: Bool = try pawnLeafNode.byKey(Keys.useHitPoints).value()
            let hasToolTips: Bool = try pawnLeafNode.byKey(Keys.hasToolTips).value()
            
            var newPawn: Pawn = Pawn(thingClass: thingClass,
                                     category: category,
                                     selectable: selectable,
                                     tickerType: tickerType,
                                     useHitPoints: useHitPoints,
                                     hasToolTip: hasToolTips)
            newPawn.className = xmlClassName
            newPawn.abstractClass = Bool(xmlAbstractClass)
            
            return newPawn
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
  
  internal init(thingClass: String, category: String, selectable: Bool, tickerType: String, useHitPoints: Bool, hasToolTip: Bool) {
    self.thingClass = thingClass
    self.category = category
    self.selectable = selectable
    self.tickerType = tickerType
    self.useHitPoints = useHitPoints
    self.hasToolTip = hasToolTip
  }
  
  mutating func markForDatabase(className: String, abstractClass: Bool, parentClass: String?, subclasses: [String]?) {
    self.className = className
    self.abstractClass = abstractClass
    self.parentClass = parentClass
    self.subclasses = subclasses
  }
  
}