//
//  AnimalBase.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/29/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

internal struct AnimalBase: XMLIndexerDeserializable, DatabaseMarkable {
  struct Keys {
    static let statBases: String = "statBases"
    static let flammability: String = "Flammability"
    static let leatherAmount: String = "LeatherAmount"
    static let baseManhunterOnDamageChance: String = "manhunterOnDamageChance"
    static let baseManhunterOnTameFailChance: String = "manhunterOnTameFailChance"
    static let nameOnNuzzleChance: String = "nameOnNuzzleChance"
  }
  
  var flammability: Float
  var leatherAmount: Int
  var manhunterOnDamageChance: Float
  var manhunterOnTameFailChance: Float
  var nameOnNuzzleChance: Float
  
  var className: String = ""
  var abstractClass: Bool = false
  var parentClass: String?
  var subclasses: [String]?
  
  static func deserialize(node: XMLIndexer) throws -> AnimalBase {
    if let baseRootNodes: [XMLIndexer] = try? node.byKey("Defs").children {
      for baseLeafNode in baseRootNodes {
        
        // the variance and complexity of these XML's isn't making for a very scalable solution to indexing everything...
        // also considering that the structure of the XML's themselves change frequently, this static code will need 
        // constant revising. 
        // lastly, not only is the structure of the XML changing but the keys are as well
        
        // unless it is at least possible to verify the core keys for each "ThingDef", I don't currently see a way to build
        // this database and also maintain it on future releases
        if let xmlClassName = baseLeafNode.element?.attributes["Name"],
          xmlAbstractClass = baseLeafNode.element?.attributes["Abstract"] {
          do {
            let flammability: Float = try baseLeafNode.byKey("statBases").byKey(Keys.flammability).value()
            let leather: Int = try baseLeafNode.byKey("statBases").byKey(Keys.leatherAmount).value()
            let manHuntDamage: Float = try baseLeafNode.byKey("race").byKey(Keys.baseManhunterOnDamageChance).value()
            let manHuntTame: Float = try baseLeafNode.byKey("race").byKey(Keys.baseManhunterOnTameFailChance).value()
            let nameOnNuzzle: Float = try baseLeafNode.byKey("race").byKey(Keys.nameOnNuzzleChance).value()
            
            var baseAnimal: AnimalBase = AnimalBase(flammability: flammability, leatherAmount: leather, manhunterOnDamageChance: manHuntDamage, manhunterOnTameFailChance: manHuntTame, nameOnNuzzleChance: nameOnNuzzle)
            baseAnimal.className = xmlClassName
            baseAnimal.abstractClass = Bool(xmlAbstractClass)
            
            if let parentClass = baseLeafNode.element?.attributes["ParentName"] {
              baseAnimal.parentClass = parentClass
            }
            
            return baseAnimal
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
  
  init(flammability: Float, leatherAmount: Int, manhunterOnDamageChance: Float, manhunterOnTameFailChance: Float, nameOnNuzzleChance: Float) {
    self.flammability = flammability
    self.leatherAmount = leatherAmount
    self.manhunterOnDamageChance = manhunterOnDamageChance
    self.manhunterOnTameFailChance = manhunterOnTameFailChance
    self.nameOnNuzzleChance = nameOnNuzzleChance
  }

  func markForDatabase(className: String, abstractClass: Bool, parentClass: String?, subclasses: [String]?) {
    
  }
  
}