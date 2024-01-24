//
//  MySensorViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 20/04/23.
//

import Foundation
import RookMotionSDK

class MySensorViewModel: ObservableObject {
  
  // MARK:  Properties
  
  private let rmManager: RMClass = RMClass()
  
  @Published var userSensors: [UserSensorViewModel] = []
  
  // MARK:  Helpers
  
  func getUserSensor() {
    rmManager.getUserSensors() { [weak self] (_, sensors) in
      DispatchQueue.main.async {
        if let userSensor = sensors {
          self?.userSensors = userSensor.map { UserSensorViewModel(rookSensor: $0) }
        }
      }
    }
  }
  
  func deleteSensor(sensor: IndexSet) {
    guard let item: Int =  sensor.first else {
      return
    }
    
    let sensor: UserSensorViewModel = userSensors[item]
    
    rmManager.deleteSensor(sensor: sensor.sensorAPi) { [weak self] result in
      
      switch result {
      case .success(_):
        self?.getUserSensor()
      case .failure(let error):
        debugPrint("Error while deleting sensor \(error)")
      }
      
    }
  }
  
}
