//
//  HomeHostingController.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import UIKit
import SwiftUI

class HomeHostingController: UIViewController {
  
  // MARK:  Properties
  
  let contentView: UIHostingController = UIHostingController(rootView: HomeView())
  
  // MARK:  Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addChild(contentView)
    view.addSubview(contentView.view)
    contentView.view.translatesAutoresizingMaskIntoConstraints = false
    contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
}
