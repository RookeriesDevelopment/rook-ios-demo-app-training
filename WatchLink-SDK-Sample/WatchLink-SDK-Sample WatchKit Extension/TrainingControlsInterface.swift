//
//  TrainingControlsInterface.swift
//  WatchLink-SDK-Sample WatchKit Extension
//
//  Created by Francisco Guerrero Escamilla on 25/04/22.
//

import WatchKit
import Foundation
import RookMotionWatchLink

class TrainingControlsInterface: WKInterfaceController {
  
  //MARK: - Outlet
  
  @IBOutlet weak var resumLaterButtonGroup: WKInterfaceGroup!
  @IBOutlet weak var startPauseButton: WKInterfaceButton!
  @IBOutlet weak var StopButton: WKInterfaceButton!
  
  //MARK: - Properties
  
  private var workoutConfiguration : WorkoutConfiguration?
  
  //MARK: - Life Cycle
  
  deinit {
    NotificationCenter.default.removeObserver(self,
                                              name: NSNotification.Name.init(kWorkoutStateNotification),
                                              object: nil)
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
  }
  
  override func willActivate() {
    
    super.willActivate()
  }
  
  override func didDeactivate() {
    super.didDeactivate()
  }
  
  override func didAppear() {
    super.didAppear()
    addCallBacks()
  }
  
  override func willDisappear() {
    super.willDisappear()
  }
  
  //MARK: - Actions
  
  @IBAction func startPauseButtonTap() {
    NotificationCenter.default.post(name: NSNotification.Name.init(kTrainingPlayPuseNotification),
                                    object: self,
                                    userInfo: nil)
  }
  
  @IBAction func stopButtonTap() {
    NotificationCenter.default.post(name: NSNotification.Name.init(kTrainingStopNotification),
                                    object: self,
                                    userInfo: nil)
  }
  
  @IBAction func stopLaterTap() {
    NotificationCenter.default.post(name: NSNotification.Name.init(kTrainingStopLaterNotification),
                                    object: self,
                                    userInfo: nil)
  }
  
  
  @objc private func stateWorkout(_ noti: Notification) {
    if let info = noti.userInfo, let state = info["state"] as? WorkoutState {
      DispatchQueue.main.async {
        switch state {
        case .started:
          self.startPauseButton.setBackgroundColor(.orange)
          self.startPauseButton.setTitle("Pause")
          self.StopButton.setHidden(false)
          self.resumLaterButtonGroup.setHidden(false)
          break
        case .stopped:
          DispatchQueue.main.async {
            WKInterfaceController.reloadRootPageControllers(withNames: ["workoutListInterface"],
                                                            contexts: nil,
                                                            orientation: .horizontal,
                                                            pageIndex: 0)
          }
          break
        case .paused:
          self.startPauseButton.setBackgroundColor(.green)
          self.startPauseButton.setTitle("resume")
          self.StopButton.setHidden(false)
          break
        @unknown default:
          break
        }
      }
    }
  }
  
  //MARK: - Helpers
  
  private func configureContext(context: Any?) {
    let workoutDictonary = context as? [String : Any]
    workoutConfiguration = workoutDictonary?["trainingConfiguration"] as? WorkoutConfiguration
  }
  
  private func addCallBacks() {
    NotificationCenter.default.addObserver(self, selector: #selector(stateWorkout),
                                           name: NSNotification.Name.init(kWorkoutStateNotification),
                                           object: nil)
  }
  
}
