//
//  UserInfoViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import Foundation
import RookMotionSDK

class UserInfoViewModel: ObservableObject {
  
  // MARK:  Properties
  
  private let storageManager: RMStorageManager = RMStorageManager()
  
  @Published var isUserStored: Bool = false
  var user: RookUserInfo?
  
  // MARK:  Helpers
  
  func getUserInfo() {
    guard let user = storageManager.readUserInfo() else {
      isUserStored = false
      return
    }
    self.user = RookUserInfo(name: user.name,
                             lastName: user.lastName1,
                             lastName2: user.lastName2,
                             email: user.email ?? "",
                             birthday: user.birthday,
                             sex: user.sex,
                             pseudonym: user.pseudonym ?? "",
                             weight: user.physiologicalVariables?.weight,
                             height: user.physiologicalVariables?.height,
                             restingHeartRate: user.physiologicalVariables?.restingHeartRate)
    
    isUserStored = true
    
  }
  
}
