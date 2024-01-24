//
//  PedningTrianingsViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 05/12/22.
//

import Foundation
import RookMotionSDK

class PendningTrianingsViewModel: ObservableObject {
  
  // MARK:  Properties
  
  private let storage: RMStorageManager = RMStorageManager()
  
  @Published var unisfinishedTrainings: [RMTrainingInfo]  = []
  
  @Published var pendingTrainings: [RMTrainingInfo]  = []
  
  // MARK:  Helepers
  
  func getUnifinishedTrainigns() {
    let trainings: [RMTrainingInfo] = storage.getUnfinishedTrainings().sorted(by: {
      $0.start ?? "" > $1.start ?? ""
    })
    unisfinishedTrainings = trainings
  }
  
  func getPendingTrainigns() {
    let trainings: [RMTrainingInfo] = storage.getPendingTrainings().sorted(by: {
      $0.start ?? "" > $1.start ?? ""
    })
    pendingTrainings = trainings
  }
  
}
