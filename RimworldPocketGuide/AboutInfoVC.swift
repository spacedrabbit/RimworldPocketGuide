//
//  AboutInfoVC.swift
//  RimworldPocketGuide
//
//  Created by Louis Tur on 7/21/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit
import SWXMLHash

class AboutInfoVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    
    setupViewHierarchy()
    configureConstraints()
    
    let dismissGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
    self.view.addGestureRecognizer(dismissGesture)
  }
  
  func dismissModal() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  private func configureConstraints() {
    self.rimworldLogo.snp_makeConstraints { (make) in
      make.top.equalTo(self.view).offset(24.0)
      make.centerX.equalTo(self.view)
      make.width.lessThanOrEqualTo(self.view)
    }
    
    self.aboutLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.rimworldLogo.snp_bottom).offset(20.0)
      make.centerX.equalTo(self.view)
    }
    
    self.aboutDetails.snp_makeConstraints { (make) in
      make.top.equalTo(self.aboutLabel.snp_bottom).offset(12.0)
      make.centerX.equalTo(self.view)
      make.width.lessThanOrEqualTo(self.view)
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(rimworldLogo)
    self.view.addSubview(aboutLabel)
    self.view.addSubview(aboutDetails)
    
    rimworldLogo.contentMode = .ScaleAspectFit
    loadAboutInfo()
  }
  
  /** 
   Loads About.xml for basic info on RimWorld
   */
  private func loadAboutInfo() {
    guard
      let destinationPath: NSURL = NSBundle.mainBundle().URLForResource("About", withExtension: "xml"),
      let data: NSData = NSData(contentsOfURL: destinationPath),
      let xmlIndexer: XMLIndexer = SWXMLHash.parse(data)
    else { return }
    
    do {
      let aboutInfo: AboutInfo = try AboutInfo.deserialize(xmlIndexer)
      self.aboutDetails.text = aboutInfo.description
    }
    catch {
      if let parseError: XMLDeserializationError = error as? XMLDeserializationError {
        ErrorHelper.handle(parseError)
      }
    }
    
  }
  
  // MARK: - Helper
  internal static func loadLogo() -> UIImage? {
    return UIImage(named: "Preview", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil)
  }
  
  // MARK: - Lazy Instances
  internal lazy var aboutLabel: UILabel = {
    let label: UILabel = UILabel()
    label.text = "About"
    label.font = UIFont(name: "Menlo", size: 24.0)
    label.textColor = UIColor.blackColor()
    return label
  }()
  
  internal lazy var aboutDetails: UILabel = {
    let label: UILabel = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .Center
    label.font = UIFont(name: "Menlo", size: 18.0)
    label.textColor = UIColor.blueColor()
    return label
  }()
  
  internal lazy var rimworldLogo: UIImageView = UIImageView(image: AboutInfoVC.loadLogo())
  
}
