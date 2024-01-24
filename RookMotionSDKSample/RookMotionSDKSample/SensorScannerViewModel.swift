//
//  SensorScannerViewModel.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import Foundation
import RookMotionSDK
import CoreBluetooth

class SensorScannerViewModel: ObservableObject {
  
  // MARK:  Properties
  
  private let sensorManager: RMSensorManager = RMSensorManager.shared
  let storageManager: RMStorageManager = RMStorageManager()
  let rmManager: RMClass = RMClass()
  let rmSensor: RMSensorAPI = RMSensorAPI()
  var trainingUUID: String?
  
  private var isScanning: Bool = false
  
  @Published var sensorList: [Sensor] = []
  @Published var peripheralList: [CBPeripheral] = []
  @Published var buttonTitle: String = "Start Scan"
  @Published var sensorAdded: Bool = false
  @Published var isTrainingListActive: Bool = true
  var message: String = ""

  
  // MARK:  Helepers
  
  func isUserStored() -> Bool {
    return storageManager.readUserInfo() != nil
  }
  
  func initScanner() {
    sensorManager.dicoveryDelegate = self
  }
  
  func scan() {
    if (isScanning) {
      stopScan()
    } else {
      startScan()
    }
  }
  
  private func startScan() {
    sensorManager.startDiscovery()
    isScanning = true
    buttonTitle = "Stop Scan"
  }
  
  private func stopScan() {
    sensorManager.stopDiscovery()
  }
  
  func releaseResources() {
    sensorManager.dicoveryDelegate = nil
    sensorManager.stopDiscovery()
  }
  
  func addSensorToUser(sensor: CBPeripheral) {
    rmManager.addSensor(sensor: rmSensor.createSensorFromPeripheral(sensor)) { [weak self] (response, uuid) in
      self?.sensorAdded = response.success
      self?.message = response.success ? "sensor added" : "The sensor could not be added \(response.message)"
     debugPrint(response)
    }
  }
  
}

extension SensorScannerViewModel: RMSensorDiscoveryCallback {
  func onSensorDiscovered(sensorList: [CBPeripheral]) {
    DispatchQueue.main.async {
      self.peripheralList = sensorList
      self.sensorList = sensorList.map { sensor in
        return Sensor(name: sensor.name ?? "sensor", peripheral: sensor)
      }
    }
  }
  
  func onDiscoveryStopped(sensorList: [CBPeripheral]) {
    DispatchQueue.main.async {
      self.isScanning = false
      self.buttonTitle = "Start Scan"
      self.peripheralList = sensorList
      self.sensorList = sensorList.map { sensor in
        return Sensor(name: sensor.name ?? "sensor", peripheral: sensor)
      }
    }
  }
  
  
}
