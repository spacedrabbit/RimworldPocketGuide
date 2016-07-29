//
//  IndexedTableViewController.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/26/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import SWXMLHash

class IndexedTableViewController: UITableViewController, UISearchResultsUpdating {
  private struct BiomeURLs {
    static let arid: String = "Biomes_Arid"
    static let cold: String = "Biomes_Cold"
    static let moderate: String = "Biomes_Moderate"
  }
  let searchController = UISearchController(searchResultsController: nil)
  var biomes: [Biome] = []
  var filteredResults: [Biome] = []
  
  override func viewDidLoad() {
    if let locatedBiomes: [Biome] = self.loadBiomes([BiomeURLs.arid, BiomeURLs.cold, BiomeURLs.moderate]) {
      self.biomes = locatedBiomes
    }
    
    self.title = "Rimworld: Pocket"
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(showAboutInfo))
    
    self.definesPresentationContext = true
    self.searchController.dimsBackgroundDuringPresentation = false
    self.searchController.searchResultsUpdater = self
    self.tableView.tableHeaderView = searchController.searchBar
  }
  
  @objc func showAboutInfo() {
    let destinationVC = AboutInfoVC()
    self.presentViewController(destinationVC, animated: true, completion: nil)
  }
  
  
  // MARK: - Search Results
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    self.filterContentFor(searchController.searchBar.text!)
  }
  
  
  // MARK: - Helpers
  func filterContentFor(searchText: String, scope: String = "All") {
    filteredResults = self.biomes.filter{ (biome: Biome) in
      return biome.name.lowercaseString.containsString(searchText.lowercaseString)
    }
    
    self.tableView.reloadData()
  }
  
  func loadBiomes(filenames: [String]) -> [Biome]? {
    var biomes: [Biome]?
    
    for filename in filenames {
      if let locatedURL: NSURL = NSBundle.mainBundle().URLForResource(filename, withExtension: "xml") {
        if let locatedBiomes: [Biome] = Biome.parseBiomesFromURL(locatedURL) {
          if biomes == nil { biomes = [Biome]() }
          biomes!.appendContentsOf(locatedBiomes)
        }
      }
    }
    return biomes
  }
  
  
  // MARK: - TableView Data/Delegate
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return self.filteredResults.count
    }
    return self.biomes.count > 0 ? self.biomes.count : 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("biomeCell")
    if cell == nil {
      cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "biomeCell")
    }
    
    var biomeForCell: Biome
    if searchController.active && searchController.searchBar.text != "" {
      biomeForCell = self.filteredResults[indexPath.row]
    }
    else {
      biomeForCell = self.biomes[indexPath.row]
    }
    
    cell?.textLabel?.text = biomeForCell.name
    cell?.detailTextLabel?.text = biomeForCell.biomeDescription
    
    return cell!
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 { return "Biomes" }
    
    return "Unknown"
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var selectedBiome: Biome
    if self.searchController.active && self.searchController.searchBar.text != "" {
      selectedBiome = self.filteredResults[indexPath.row]
    }
    else {
      selectedBiome = self.biomes[indexPath.row]
    }
    
    let dtvc: BiomeTableViewController = BiomeTableViewController()
    dtvc.selectedBiome = selectedBiome

    self.showViewController(dtvc, sender: self)
  }
}
