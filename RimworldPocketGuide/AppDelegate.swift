//
//  AppDelegate.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SWXMLHash

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    if let pawnBaseDefUrl: NSURL = NSBundle.mainBundle().URLForResource("Races_Animal_Base", withExtension: "xml") {
      if let pawnData: NSData = NSData(contentsOfURL: pawnBaseDefUrl) {
        if let pawnIndexer: XMLIndexer = SWXMLHash.parse(pawnData) {
          if let pawn: Pawn = try? Pawn.deserialize(pawnIndexer) {
            print("Pawn parsed: \(pawn)")
          }
          
          if let baseAnimal: AnimalBase = try? AnimalBase.deserialize(pawnIndexer) {
            print("Base Animal parsed: \(baseAnimal)")
          }
        }
      }
    }

    
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    let root = UINavigationController(rootViewController: IndexedTableViewController())
    self.window?.rootViewController = root
    self.window?.makeKeyAndVisible()
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

