//
//  AddUserViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import Foundation
import RookMotionSDK

class AddUserViewModel: ObservableObject {
  
  // MARK:  Properties
  
  let rookMasterClass: RMClass = RMClass()
  let rookStorage: RMStorageManager = RMStorageManager()
  
  @Published var userEmail: String = ""
  @Published var isValidEmail: Bool = false
  @Published var userAdded: Bool = false
  var message: String = ""
  // MARK:  Helepers
  
  
  func textFieldValidatorEmail(_ string: String) {
    if (string.count > 100 && !string.isEmpty)  {
      isValidEmail = false
      return
    }
  
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    isValidEmail = emailPredicate.evaluate(with: string)
  }
  
  func addUser() {
    textFieldValidatorEmail(userEmail)
    if isValidEmail {
      rookMasterClass.addUser(email: userEmail) { [weak self] response in
        DispatchQueue.main.async {
          self?.userAdded = response.success
          self?.message = response.success ? "User added" : "The user could not be added \(response.message)"
        }
      }
    }
  }
  
  func readUser() {
    guard let user = rookStorage.readUserInfo() else {
      return
    }
    
    userEmail = user.email ?? ""
  }
  
  
}
