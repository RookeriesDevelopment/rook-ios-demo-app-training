//
//  TrainingMetricsInterface.swift
//  WatchLink-SDK-Sample WatchKit Extension
//
//  Created by Francisco Guerrero Escamilla on 25/04/22.
//

import WatchKit
import Foundation
import RookMotionWatchLink

let kTrainingPlayPuseNotification = "kTrainingPlayPuseNotification"
let kTrainingStopNotification = "kTrainingStopNotification"
let kTrainingStopLaterNotification = "kTrainingStopLaterNotification"
let kWorkoutStateNotification = "kWorkoutStateNotification"

class TrainingMetricsInterface: WKInterfaceController {
  
  //MARK: - Outlet
  
  @IBOutlet weak var trainingDuration: WKInterfaceLabel!
  @IBOutlet weak var caloriesLabel: WKInterfaceLabel!
  @IBOutlet weak var hearRateLabel: WKInterfaceLabel!
  @IBOutlet weak var effortLabel: WKInterfaceLabel!
  
  //MARK: - Properties
  
  private var workoutConfiguration : RookTrainingConfiguration?
  private let workOutManager = WorkoutManager()
  
  //MARK: - Life Cycle
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    configureContext(context: context)
    configureCallBackControls()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kTrainingPlayPuseNotification),
                                              object: nil)
    
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kTrainingStopNotification),
                                              object: nil)
    
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kTrainingStopLaterNotification),
                                              object: nil)
    debugPrint("deinit")
  }
  
  override func willActivate() {
    
    super.willActivate()
  }
  
  override func didDeactivate() {
    
    super.didDeactivate()
  }
  
  override func didAppear() {
    super.didAppear()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(workoutHrData),
                                           name: NSNotification.Name.init(kWorkoutHearRateData),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(workoutStepData),
                                           name: NSNotification.Name.init(kWorkoutStepData),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(workoutDuration),
                                           name: NSNotification.Name.init(kWorkoutDuration),
                                           object: nil)
    
  }
  
  override func willDisappear() {
    super.willDisappear()
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kWorkoutHearRateData),
                                              object: nil)
    
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kWorkoutStepData),
                                              object: nil)
    
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kWorkoutDuration),
                                              object: nil)
  }
  
  //MARK: - Selectors
  
  @objc func playPauseWorkout(_ notification: Notification) {
    if workOutManager.state == .stopped || workOutManager.state == .paused {
      guard let configuaration = self.workoutConfiguration else {
        return
      }
      self.workOutManager.start(configuration: configuaration)
      becomeCurrentPage()
    } else {
      workOutManager.pauseTraining()
    }
  }
  
  @objc func stopWorkout(_ notification: Notification) {
    workOutManager.stopTraining() { response in
      debugPrint(response)
    }
  }
  
  @objc func resumeLater(_ notification: Notification) {
    workOutManager.resumenLater()
  }
  
  @objc func workoutHrData(_ notification: Notification) {
    
    guard let info = notification.userInfo,
          let jsonData = try? JSONSerialization.data(withJSONObject: info,
                                                     options: .prettyPrinted),
          let hrData = try? JSONDecoder().decode(RMHrDerivedRecord.self,
                                                 from: jsonData) else {
      return
    }
    
    DispatchQueue.main.async {
      self.caloriesLabel.setText("\(String(format: "%.0f", hrData.calories))")
      debugPrint(hrData)
      self.hearRateLabel.setText("\(hrData.heartRate )")
      
      self.effortLabel.setText("\(String(format: "%.0f", hrData.effort))")
    }
    
  }
  
  @objc func workoutStepData(_ notification: Notification) {
    
  }
  
  @objc func workoutDuration(_ notification: Notification) {
    
    guard let userInfo = notification.userInfo else {
      return
    }
    
    guard let durationF = userInfo["duration"] as? Float else {
      return
    }
    let durationInt = Int(durationF.rounded(.toNearestOrAwayFromZero))
    DispatchQueue.main.async {
      self.trainingDuration.setText(self.formatTimeInterval(elapsedSeconds: durationInt))
    }
  }
  
  //MARK: - Helpers
  
  private func configureCallBackControls() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(playPauseWorkout),
                                           name: NSNotification.Name.init(kTrainingPlayPuseNotification),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(stopWorkout),
                                           name: NSNotification.Name.init(kTrainingStopNotification),
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(resumeLater),
                                           name: NSNotification.Name.init(kTrainingStopLaterNotification),
                                           object: nil)
    
  }
  
  private func configureContext(context: Any?) {
    let workoutDictonary = context as? [String : Any]
    workoutConfiguration = workoutDictonary?["trainingConfiguration"] as? RookTrainingConfiguration
    workOutManager.delegate = self
  }
  
  func formatTimeInterval(elapsedSeconds: Int) -> String {
    var time = elapsedSeconds
    let hours = time / 3600
    time = time % 3600
    let minutes = time / 60
    let seconds = time % 60
    return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
  }
  
}


//MARK: - WorkourDelegate extension

extension TrainingMetricsInterface: WorkoutManagerDelegate {
  func workoutManager(_ manager: WorkoutManager, didChangeStateTo newState: WorkoutState) {
    
    NotificationCenter.default.post(name: NSNotification.Name.init(kWorkoutStateNotification),
                                    object: self,
                                    userInfo: ["state": newState])
    
  }
  
  func workoutManager(_ manager: WorkoutManager,
                      didChangeHeartRateTo hearRateData: RMHrDerivedRecord) {
    
  }
  
  func workoutManager(_ manager: WorkoutManager,
                      didChangeStepCount stepData: RMStepDerivedRecord) {
    
  }
  
  func didFinishWorkOut(_ manager: WorkoutManager) {
    
    NotificationCenter.default.post(name: NSNotification.Name.init(kWorkoutStateNotification),
                                    object: self,
                                    userInfo: ["state": WorkoutState.stopped])
    DispatchQueue.main.async {
      self.presentController(withName: "workoutListInterface",
                             context: nil)
    }
  }
  
  
}
