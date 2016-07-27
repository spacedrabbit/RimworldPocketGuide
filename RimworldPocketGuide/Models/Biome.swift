//
//  Biome.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/22/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

internal enum BiomeCategory: String {
  case Arid = "Arid"
  case Cold = "Cold"
  case Moderate = "Moderate"
}

internal struct Biome: XMLIndexerDeserializable {
//  var temperateCategory: BiomeCategory
  var name: String
  var label: String
  var biomeDescription: String
  var workerClass: String
  var plantDensity: Float
  var animalDensity: Float
  var diseaseMtbDays: Int
//  let terrains: [String]
//  let weatherTypes: [String]
//  let wildPlants: [String]
//  let wildAnimals: [String]
//  let allowedPackAnimals: [String]
  
  private struct Keys {
    static let root: String = "Defs"
    
    static let biomeLabel: String = "label"
    static let biomeDef: String = "BiomeDef"
    static let biomeName: String = "defName"
    static let biomeDescription: String = "description"
    static let biomeWorkerClass: String = "workerClass"
    static let biomeAnimalDensity: String = "animalDensity"
    static let biomePlantDensity: String = "plantDensity"
    static let biomeDiseaseMtbDays: String = "diseaseMtbDays"
    
    struct biomeDiseases {
      static let root: String = "diseases"
      static let subRoot: String = "li"
      
      static let diseaseName: String = "diseaseInc"
      static let diseaseCommonality: String = "commonality"
    }
    
    struct biomeTerrain {
      static let root: String = "terrainsByFertility"
      
      static let name: String = "terrain"
      static let minFertility: String = "min"
      static let maxFertility: String = "max"
    }
    
    struct biomeBaseWeatherCommonalities {
      static let root: String = "baseWeatherCommonalities"
      
      static let clear: String = "Clear"
      static let fog: String = "Fog"
      static let dryThunderstorm: String = "DryThunderstorm"
      static let rainyThunderstorm: String = "RainyThunderstorm"
      static let foggyRain: String = "FoggyRain"
      static let snowGentle: String = "SnowGentle"
      static let snowHard: String = "SnowHard>"
    }
    
    struct biomewildPlants{
      static let root: String = "wildPlants"
      static let plantAgave: String = "PlantAgave"
      static let plantSaguaroCactus: String = "PlantSaguaroCactus"
      static let plantPincushionCactus: String = "PlantPincushionCactus"
      static let plantRaspberry: String = "PlantRaspberry"
      static let plantBush: String = "PlantBush"
      static let plantGrass: String = "PlantGrass"
      static let plantDandelion: String = "PlantDandelion"
      static let plantTreeOak: String = "PlantTreeOak"
      static let plantTreePoplar: String = "PlantTreePoplar"
    }
    
    struct biomeWildAnimals {
      static let root: String = "wildAnimals"
      
      static let muffalo: String = "Muffalo"
      static let gazelle: String = "Gazelle"
      static let ibex: String = "Ibex"
      static let alpaca: String = "Alpaca"
      static let elephant: String = "Elephant"
      static let squirrel: String = "Squirrel"
      static let boomRat: String = "Boomrat"
      static let iguana: String = "Iguana"
      static let rhinoceros: String = "Rhinoceros"
      static let wildBoard: String = "WildBoar"
      static let boomalope: String = "Boomalope"
      static let emu: String = "Emu"
      static let ostrich: String = "Ostrich"
      static let rat: String = "Rat"
      static let megatherium: String = "Megatherium"
      static let cougar: String = "Cougar"
      static let wolfTimber: String = "WolfTimber"
      static let foxFennec: String = "FoxFennec"
      
      static let allowedPackAnimals: String = "allowedPackAnimals"
    }
    
    
  } // end keys
  
  static func deserialize(node: XMLIndexer) throws -> Biome {
    if let biomeRootNodeAll: XMLIndexer = node.all.first {
      
      do {
        let name: String = try biomeRootNodeAll.byKey(Keys.biomeName).value()
        let label: String = try biomeRootNodeAll.byKey(Keys.biomeLabel).value()
        let biomeDescription: String = try biomeRootNodeAll.byKey(Keys.biomeDescription).value()
        let workerClass: String = try biomeRootNodeAll.byKey(Keys.biomeWorkerClass).value()
        let animalDensity: Float = try biomeRootNodeAll.byKey(Keys.biomeAnimalDensity).value()
        let plantDensity: Float = try biomeRootNodeAll.byKey(Keys.biomePlantDensity).value()
        let diseaseMtbDays: Int = try biomeRootNodeAll.byKey(Keys.biomeDiseaseMtbDays).value()
        
        print("All went will with \(#function) deserializaion")
        return Biome(name: name, label: label, biomeDescription: biomeDescription,
                     workerClass: workerClass, plantDensity: plantDensity,
                     animalDensity: animalDensity, diseaseMtbDays: diseaseMtbDays)
      } catch {
        print("\(#function) threw!")
      }
    }

    throw XMLDeserializationError.NodeHasNoValue
  }

  static func parseBiomesFromURL(url: NSURL) -> [Biome]? {
    var biomes: [Biome]? = []
    
    guard
      let destinationPath: NSURL = url,
      let data: NSData = NSData(contentsOfURL: destinationPath),
//      let xmlString: String = String(data: data, encoding: NSUTF8StringEncoding),
      let xmlIndexer: XMLIndexer = SWXMLHash.config({ (configOptions: SWXMLHashOptions) in
      }).parse(data)
      
      else { return nil }
    
    if let biomeNodes: [XMLIndexer] = xmlIndexer[Keys.root].children {
      for biomeLeafNode: XMLIndexer in biomeNodes {
        do {
          let biome: Biome = try Biome.deserialize(biomeLeafNode)
          biomes?.append(biome)
        }
        catch {
          print("THROWS! \(#function)")
          // TODO
        }
      }
    }
    
    return biomes
  }
  
}