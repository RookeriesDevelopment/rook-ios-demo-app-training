//
//  UnfinishedTrainingsViewModel.swift
//  WatchLink-SDK-Sample
//
//  Created by Francisco Guerrero Escamilla on 07/12/22.
//

import Foundation
import RookMotionSDK

class UnfinishedTrainignsViewModel: ObservableObject {
  
  // MARK:  Properties
  
  private let storage: RMStorageManager = RMStorageManager()
  
  @Published var unfinishTrainings: [RMTrainingInfo] = []
  
  // MARK:  Helpers
  
  func getUnfinishedTrainigs() {
    let trainings: [RMTrainingInfo] = storage.getUnfinishedTrainings().sorted(by: {
      $0.start ?? "" > $1.start ?? ""
    })
    
    unfinishTrainings = trainings
    
  }
  
}

