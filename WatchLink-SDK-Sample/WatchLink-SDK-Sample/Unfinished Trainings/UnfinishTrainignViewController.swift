//
//  UnfinishTrainignViewController.swift
//  WatchLink-SDK-Sample
//
//  Created by Francisco Guerrero Escamilla on 07/12/22.
//

import UIKit
import SwiftUI

class UnfinishTrainignViewController: UIViewController {
  
  let hostingController: UIHostingController = UIHostingController(rootView: UnfinishedTrainingsView())
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    addChild(hostingController)
    view.addSubview(hostingController.view)
    setConstrains()
  }
  
  private func setConstrains() {
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
}
