//
//  WorkoutRowView.swift
//  WatchLink-SDK-Sample WatchKit Extension
//
//  Created by Francisco Guerrero Escamilla on 26/04/22.
//

import WatchKit
import RookMotionWatchLink

class WorkoutRowView: NSObject {
  
  //MARK: - Properties
  
  var workoutType: RWRookTrainingType?
  @IBOutlet weak var workoutLabel: WKInterfaceLabel!
  
  //MARK: - Helpers
  
  func setRowData(workout: RWRookTrainingType) {
    workoutLabel.setText(workout.trainigName)
    self.workoutType = workout
  }
  
}
