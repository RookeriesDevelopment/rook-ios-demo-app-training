//
//  ViewController.swift
//  WatchLink-SDK-Sample
//
//  Created by Francisco Guerrero Escamilla on 19/04/22.
//

import UIKit
import RookMotionSDK
import WatchConnectivity

class ViewController: UIViewController {
  
  //MARK: - Properties
  
  let RMManager = RMClass()
  let storageManager = RMStorageManager()
  let apiManager = RMApi()
  
  //MARK: - Outlet
  
  //MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    RMCommunicationManager.shared.delegate = self
    createUser()
  }
  
  //MARK: - Actions
  
  @IBAction func showUnfinishTrainings(_ sender: Any) {
    let vc: UIViewController = UnfinishTrainignViewController()
    self.present(vc,animated: true)
  }
  
  @IBAction func showHistoryTap(_ sender: Any) {
    getUserHistory()
  }
  
  //MARK: - Helpers
  
  private func createUser() {
    print("test")
    RMManager.addUser(email: "userTest0425@email.com") { [weak self] RMresponse in
      if RMresponse.success {
        print(RMresponse)
        DispatchQueue.main.async {
          autoreleasepool() {
            self?.updateUserInfo()
          }
        }
      }
    }
  }
  
  private func updateUserInfo() {
    if let user = storageManager.readUserInfo() {
      
      user.name = "UserTest"
      user.lastName1 = "lastame1"
      user.lastName2 = "lastname2"
      user.phone = "5520350995"
      user.birthday = "1994-10-04"
      user.sex = "male"
      user.pseudonym = "testios"
      
      user.physiologicalVariables?.height = "171"
      user.physiologicalVariables?.weight = "78"
      user.physiologicalVariables?.restingHeartRate = "60"
      
      self.RMManager.updateUserProfile(user: user) { [weak self] (response) in
        print("Debug response \(response)")
      }
    }
  }
  
  private func getUserHistory() {
    let viewController = HistoryTableController()
    self.present(viewController, animated: true)
  }
  
  fileprivate func showSyncNotification() {
    let alert = UIAlertController(title: "Sync", message: "Do you wanto to send the user information to apple watch", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
    }))
    
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
      DispatchQueue.main.async {
        autoreleasepool() {
          RMCommunicationManager.shared.syncUserInfo()
        }
      }
    }))
    
    
    self.present(alert, animated: true, completion: nil)
  }
  
}

extension ViewController: CommunicationDelegate {
  func session(_ session: WCSession, messageData: [String : Any]) {
    print("user message \(messageData)")
  }
  
  func session(_ session: WCSession, userInfo: [String : Any]) {
    print("user info \(userInfo)")
    
    if let _ = userInfo["sync"] {
      DispatchQueue.main.async {
        self.showSyncNotification()
      }
    }
  }
  
  
}

