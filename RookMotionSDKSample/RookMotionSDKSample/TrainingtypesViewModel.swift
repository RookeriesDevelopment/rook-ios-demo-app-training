//
//  TrainingtypesViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 31/10/22.
//

import Foundation
import RookMotionSDK

class TrainingTypesViewModel: ObservableObject {
  
  // MARK:  Properties
  
  @Published var trainingTypes: [RMTrainingType] = []
  @Published var loading: Bool = false
  
  private let rmProvioder: RMClass = RMClass()
  
  // MARK:  Helepers
  
  func getTrainingTypes() {
    loading = true
    rmProvioder.getTrainingTypes() { [weak self] (_, trainingTypes) in
      DispatchQueue.main.async {
        self?.loading = false
        guard let trainingTypes = trainingTypes else {
          return
        }
        self?.trainingTypes = trainingTypes
      }
      
    }
  }
  
}
