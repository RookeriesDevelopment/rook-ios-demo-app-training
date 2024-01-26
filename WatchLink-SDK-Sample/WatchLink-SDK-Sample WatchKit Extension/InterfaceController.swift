//
//  InterfaceController.swift
//  WatchLink-SDK-Sample WatchKit Extension
//
//  Created by Francisco Guerrero Escamilla on 19/04/22.
//

import WatchKit
import Foundation
import RookMotionWatchLink
import WatchConnectivity

class InterfaceController: WKInterfaceController {
  
  //MARK: - Properties
  
  let communicationManager = RWCommunicationManager.shared
  let userRepository = RepositoryUser()
  let netWorkManager = NetworkManager<RWSensorAPI>()
  
  //MARK: - Life Cycle
  
  override func awake(withContext context: Any?) {
    communicationManager.delegate = self
    
    userRepository.isUserStored() { isStored in
      DispatchQueue.main.async {
        if isStored {
          self.presentWorkoutListController()
        }
      }
    }
    
  }
  
  override func willActivate() {
  }
  
  override func didDeactivate() {
    
  }
  
  //MARK: - Actions
  
  @IBAction func syncButtonTap() {
    communicationManager.syncRookUser()
  }
  
  //MARK: - Helpers
  
  func requestPermission() {
    AuthorizationManager.shared.requestAuthorization(toShare: nil,
                                                     toRead: nil) { request in
      print(request)
    }
  }
  
  func presentWorkoutListController() {
    self.communicationManager.delegate = nil
    WKInterfaceController.reloadRootPageControllers(withNames: ["workoutListInterface"],
                                                    contexts: nil,
                                                    orientation: .horizontal,
                                                    pageIndex: 0)
  }
  
}

extension InterfaceController: RWCommunicationDelegate {
  
  func session(_ session: WCSession, messageData: [String : Any]) {
    
  }
  
  func session(_ session: WCSession, userInfo: [String : Any]) {
    print("user Info \(userInfo)")
  }
  
  func userInfoSaved(_ session: WCSession, watchMessage: [String : Any]) {
    print("message \(watchMessage)")
    DispatchQueue.main.async {
      self.communicationManager.delegate = nil
      self.presentWorkoutListController()
    }
    
  }
  
  
}
