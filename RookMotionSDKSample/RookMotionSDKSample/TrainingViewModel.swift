//
//  TrainingViewModel.swift
//  RookTrainingSDKDemoApp
//
//  Created by Francisco Guerrero Escamilla on 01/08/24.
//

import Foundation
import RookMotionSDK
import CoreBluetooth

class TrainingViewModel: ObservableObject {

  private let trainingManager: RookTrainingManager = RookTrainingManager()
  private let sensor: CBPeripheral
  private let trainingTypeUUID: String

  @Published var duration: String = "00:00:00"
  @Published var heartRate: String = "--"
  @Published var steps: String = "--"
  @Published var calories: String = "--"
  @Published var effort: String = "-- %"
  @Published var sensorName: String = "..."
  @Published var battery: String = "..."
  @Published var isButtonStopActive: Bool = false
  @Published var isSummaryViewActive: Bool = false

  var trainingEndResponse: RMTrainingResponse?

  // MARK:  Init

  init(sensor: CBPeripheral,
       trainingTypeUUID: String) {
    self.sensor = sensor
    self.trainingTypeUUID = trainingTypeUUID
    self.trainingManager.trainingSensor = sensor
    self.trainingManager.training.trainingTypeUUID = trainingTypeUUID
    trainingManager.trainingDelegate = self
  }

  func onAppear() {
    trainingManager.connectSensor(sensor)
  }

  func stopTraining() {
    trainingManager.finishTraining(sensor: sensor) { (response, trainingResponse) in
      DispatchQueue.main.async {
        self.trainingEndResponse = trainingResponse
        self.isSummaryViewActive = true
      }
    }
  }

  func startTraining() {
    trainingManager.startTraining()
    isButtonStopActive = true
  }

}

extension TrainingViewModel: RookTrainingManagerDelegate {
  func durationUpdated(duration: Int) {
    let time = TimeInterval(duration)
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    DispatchQueue.main.async {
      self.duration = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
  }
  
  func heartRateDataUpdated(hrData: RookMotionSDK.RMHrDerivedRecord) {
    DispatchQueue.main.async {
      self.heartRate = "\(hrData.heartRate ?? 0) bpm"
      self.calories = "\(hrData.calories ?? 0)"
      self.effort = " \(Int(hrData.effort ?? 0.0)) %"
    }
  }
  
  func stepsUpdated(stepDerivedData: RookMotionSDK.RMStepDerivedRecord) {
    DispatchQueue.main.async {
      self.steps = "\(stepDerivedData.steps ?? 0)"
    }
  }
  
  func batteryLevelUpdated(batteryLevel: Int) {
    DispatchQueue.main.async {
      self.battery = "\(batteryLevel) %"
    }
  }

  func handleSensorConnected(peripheral: CBPeripheral) {
    DispatchQueue.main.async {
      self.sensorName = "\(peripheral.name ?? "no name")"
    }
  }
  
  func handleSensorDisconnected(peripheral: CBPeripheral) {
    debugPrint("do something to connect \(peripheral)")
  }
}
