//
//  TrainingHistoryViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 02/11/22.
//

import Foundation
import RookMotionSDK

class TrainingHistoryViewModel: ObservableObject {
  
  // MARK:  Properties
  
  let rookStorage: RMStorageManager = RMStorageManager()
  let rookAPI: RMApi = RMApi()
  let rmClass: RMClass = RMClass()
  
  @Published var trainings: [UserTraining] = []
  
  // MARK:  Helpers
  
  func getUserTrainings(context: ContextType = .viewContext) {
    
    guard let uuid = rookStorage.getUserUUID(context: context) else {
      return
    }
    
    rookAPI.retrieveTrainingsFromUser(userUUID: uuid) { [weak self] (httpCode, response, totalTrainings) in
      
      guard let jsonData: Data = response.data(using: .utf8) else {
        return
      }
      
      guard let trainings = try? JSONDecoder().decode([UserTraining].self,
                                                      from: jsonData) else {
        return
      }
      
      DispatchQueue.main.async {
        self?.trainings = trainings.sorted(by: {
          $0.start > $1.start
        })
      }
    }
  }
  
  func uploadPendingTrainigns() {
    rmClass.uploadPendingTrainings(delete: true) { [weak self] (respose) in
      debugPrint("resposne \(respose.success) \(respose.message) \(respose.code)")
      DispatchQueue.main.async {
        self?.getUserTrainings(context: .backGroundContext)
      }
    }
  }
  
}
