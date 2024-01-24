//
//  TrainingViewController.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 15/03/22.
//

import UIKit
import CoreBluetooth
import RookMotionSDK

extension TrainingViewController: RMTrainingSensorCallBack {
  func sensorDidDisconnect(sensor: CBPeripheral) {
    debugPrint("sensosr disconnected \(sensor.name ?? "no name")")
  }
}

class TrainingViewController: RMTrainingManager {
  
  //MARK: - IBOUTlets
  
  @IBOutlet weak var sensorLabel: UILabel!
  @IBOutlet weak var batterLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!
  @IBOutlet weak var hrLabel: UILabel!
  @IBOutlet weak var stepsLabel: UILabel!
  @IBOutlet weak var calories: UILabel!
  @IBOutlet weak var effortLabel: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  
  @IBOutlet weak var buttonStart: UIButton!
  
  //MARK: - Properties
  
  override var duration: Float {
    didSet {
      let time = TimeInterval(duration)
      let hours = Int(time) / 3600
      let minutes = Int(time) / 60 % 60
      let seconds = Int(time) % 60
      durationLabel.text = String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
  }
  
  //MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sensorManager.sensorDelegate = self
    sensorManager.connectionDelegate = self
    connect()
    self.disconnectionCallBack = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - IBActions
  
  
  @IBAction func startButtonTap(_ sender: Any) {
    startTraining()
    stopButton.isHidden = false
  }
  
  
  @IBAction func stopButtonTap(_ sender: Any) {
    finishTraining(sensor: trainingSensor) { (response, trainingResponse) in
      DispatchQueue.main.async {
        let viewController: TrainingSummaryController = TrainingSummaryController(summaries: trainingResponse.trainingSummaries)
        self.navigationController?.pushViewController(viewController,
                                                      animated: true)
      }
    }
  }
  
  //MARK: - Helpers
  
  func connect() {
    guard let sensorToConnect = trainingSensor else { return }
    connectSensor(sensorToConnect)
  }
  
  //MARK: - Override Methods
  
  override func displayHrMeasurements(hrData: RMHrDerivedRecord) {
    DispatchQueue.main.async {
      self.hrLabel.text = "\(hrData.heartRate ?? 0) bpm"
      self.calories.text = "\(hrData.calories ?? 0)"
      self.effortLabel.text = " \(Int(hrData.effort ?? 0.0)) %"
    }
  }
  
  override func displayStepsMeasurements(stepDerivedData: RMStepDerivedRecord) {
    DispatchQueue.main.async {
      self.stepsLabel.text = "\(stepDerivedData.steps ?? 0)"
    }
  }
  
  override func displayBatteryLevel(batteryLevel: Int) {
    DispatchQueue.main.async {
      self.batterLabel.text = "\(batteryLevel) %"
    }
  }
  
  override func handleSensorDisconnected() {
    print(#function)
  }
  
}
