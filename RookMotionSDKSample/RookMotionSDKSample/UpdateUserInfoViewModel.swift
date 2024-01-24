//
//  UpdateUserInfoViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import Foundation
import RookMotionSDK

class UpdateUserInfoViewModel: ObservableObject {
  
  // MARK:  Properties
  
  let rmClass: RMClass = RMClass()
  let storageManager: RMStorageManager = RMStorageManager()
  
  let sexOptions: [String] = ["male", "female"]
  
  @Published var userName: String = ""
  
  @Published var lastName: String = ""
  @Published var lastName2: String = ""
  @Published var pseudonym: String = ""
  @Published var sex: String = ""
  @Published var birdthday: Date = Date()
  
  @Published var weight: String = ""
  @Published var height: String = ""
  @Published var restingHeartRate: String = ""
  
  @Published var userUpdated: Bool = false
  var message: String = ""
  
  // MARK:  Helepers
  
  func isUserStored() -> Bool {
    return storageManager.readUserInfo() != nil
  }
  
  func updatedUser() {
    let userStored = storageManager.readUserInfo()
    let user = RMUser()
    user.name = userName.trimmingCharacters(in: .whitespacesAndNewlines)
    user.userUUID = userStored?.userUUID
    user.email = userStored?.email
    user.lastName1 = lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : lastName.trimmingCharacters(in: .whitespacesAndNewlines)
    
    user.lastName2 = lastName2.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : lastName2.trimmingCharacters(in: .whitespacesAndNewlines)
    
    user.pseudonym = pseudonym.trimmingCharacters(in: .whitespacesAndNewlines)
    user.sex = sex
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    user.birthday = dateFormatter.string(from: birdthday)
    
    let physical: RMUserPhysiologicalVariables = RMUserPhysiologicalVariables()
    physical.height = height
    physical.weight = weight
    physical.restingHeartRate = restingHeartRate
    
    user.physiologicalVariables = physical
    
    rmClass.updateUserProfile(user: user) { [weak self] response in
      DispatchQueue.main.async {
        self?.userUpdated = true
        self?.message = response.success ? "user updated" : response.message
      }
    }
  }
  
  func readUserInfo() {
    guard let user = storageManager.readUserInfo() else {
      return
    }
    
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-DD"
    
    self.userName = user.name ?? ""
    self.lastName = user.lastName1 ?? ""
    self.lastName2 = user.lastName2 ?? ""
    self.pseudonym = user.pseudonym ?? ""
    self.sex = user.sex ?? sexOptions[0]
    self.birdthday = dateFormatter.date(from: user.birthday ?? "") ?? Date()
    self.weight = user.physiologicalVariables?.weight ?? "70"
    self.height = user.physiologicalVariables?.height ?? "170"
    self.restingHeartRate = user.physiologicalVariables?.restingHeartRate ?? "60"
  }
  
  
}
