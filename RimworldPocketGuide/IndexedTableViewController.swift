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
  let searchController = UISearchController(searchResultsController: nil)
  var biomes: [Biome] = []
  var filteredResults: [AnyObject] = []
  
  override func viewDidLoad() {
    if let biomeURL: NSURL = NSBundle.mainBundle().URLForResource("Biomes_Arid", withExtension: "xml") {
      if let locatedBiomes: [Biome] = Biome.parseBiomesFromURL(biomeURL) {
        self.biomes = locatedBiomes
      }
    }
    
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
    // TODO: live filtering
    
    self.tableView.reloadData()
  }
  
  
  // MARK: - TableView Data/Delegate
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.biomes.count > 0 ? self.biomes.count : 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("biomeCell")
    if cell == nil {
      cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "biomeCell")
    }
    
    cell?.textLabel?.text = self.biomes[indexPath.row].name
    cell?.detailTextLabel?.text = self.biomes[indexPath.row].biomeDescription
    
    return cell!
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 { return "Biomes" }
    
    return "Unknown"
  }
}
