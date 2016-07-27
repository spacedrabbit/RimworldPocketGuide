//
//  BiomeTableViewController.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/27/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SWXMLHash

class BiomeTableViewController: UITableViewController {
  internal var selectedBiome: Biome? {
    willSet {
      let dictionaryRepresentation: Dictionary<String, AnyObject>? = newValue!.dictionaryRepresentation()
      self.selectedBiomeDictionary = dictionaryRepresentation
      self.title = newValue?.label.uppercaseString
    }
  }
  internal var selectedBiomeDictionary: Dictionary<String, AnyObject>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.selectedBiomeDictionary?.keys.count ?? 1
  }
  
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("biomeCell")
    if cell == nil {
      cell = UITableViewCell(style: .Value2, reuseIdentifier: "biomeCell")
    }
    
    if let validDictionary: Dictionary<String, AnyObject> = self.selectedBiomeDictionary {
      let allKeys = Array(validDictionary.keys)
      if let key: String = allKeys[indexPath.row],
         let value: AnyObject = Array(validDictionary.values)[indexPath.row] {
        cell?.textLabel?.text = key
        cell?.detailTextLabel?.text = "\(value)"
      }
    }
   
    
   return cell!
   }
  
}
