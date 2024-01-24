//
//  TrainingSummary.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 31/10/22.
//

import UIKit
import SwiftUI
import RookMotionSDK

class TrainingSummaryController: UIViewController {
  
  // MARK:  Properties
  
  let summaries: RMTrainingSummariesResult
  
  // MARK:  Init
  
  init(summaries: RMTrainingSummariesResult) {
    self.summaries = summaries
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK:  Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    let contentView: UIHostingController = UIHostingController(rootView: TrainingSummaryView(summaries: summaries,
                                                                                             dismissAction: {
      self.dismiss(animated: true)
    }))
    
    addChild(contentView)
    view.addSubview(contentView.view)
    contentView.view.translatesAutoresizingMaskIntoConstraints = false
    contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
}
