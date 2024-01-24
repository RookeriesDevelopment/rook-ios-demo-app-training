//
//  UserSensorViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 20/04/23.
//

import Foundation
import RookMotionSDK

struct UserSensorViewModel: Identifiable {
  
  let id: UUID = UUID()
  
  private let rookSensor: RMSensorAPI
  
  init(rookSensor: RMSensorAPI) {
    self.rookSensor = rookSensor
  }
  
  var sensorAPi: RMSensorAPI {
    return rookSensor
  }
  
  var name: String {
    return rookSensor.sensorName ?? "no name"
  }
  
  var uuid: String {
    return rookSensor.sensorUUID ?? "no uuid"
  }
  
}
