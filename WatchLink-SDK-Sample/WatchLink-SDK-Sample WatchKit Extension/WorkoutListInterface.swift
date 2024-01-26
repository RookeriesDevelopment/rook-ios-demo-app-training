//
//  WorkoutListInterface.swift
//  WatchLink-SDK-Sample WatchKit Extension
//
//  Created by Francisco Guerrero Escamilla on 26/04/22.
//

import WatchKit
import Foundation
import RookMotionWatchLink

class WorkoutListInterface: WKInterfaceController {
  
  //MARK: - Properties
  
  let authorizationManager = AuthorizationManager.shared
  let trainingTypesRepository = RepositoryTrainingTypes()
  let trainingStorage: RookTrainingStorage = RookTrainingStorage()
  
  //MARK: - Outlets
  
  @IBOutlet weak var workoutTable: WKInterfaceTable!
  
  // MARK:  init
  
  //MARK: - Life Cycle
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    requestPermission()
    let trainings = trainingStorage.getUnfinishedTrainings(context: .viewContext)
    debugPrint("un trainigns \(trainings.count)")
    BackGroundTasks.shared.uploadPendingTraining() { response in
      print(response)
    }
  }
  
  override func willActivate() {
    super.willActivate()
  }
  
  override func didDeactivate() {
    super.didDeactivate()
  }
  
  override func didAppear() {
    super.didAppear()
    loadTable()
  }
  
  //MARK: - Helpers
  
  private func requestPermission() {
    self.authorizationManager.requestAuthorization(toShare: nil,
                                                   toRead: nil) { _ in
      
    }
  }
  
  private func loadTable() {
    trainingTypesRepository.getTrainingTypes() { [weak self] (workoutList, error) in
      DispatchQueue.main.async {
        self?.workoutTable.setNumberOfRows(workoutList.count, withRowType: "workoutRow")
        self?.populateTable(workouts: workoutList)
      }
    }
  }
  
  private func populateTable(workouts: [RWRookTrainingType]) {
    for (indexRow, workoutType) in workouts.enumerated() {
      let row = workoutTable.rowController(at: indexRow) as! WorkoutRowView
      row.setRowData(workout: workoutType)
    }
  }
  
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    guard let workoutRowController = table.rowController(at: rowIndex) as? WorkoutRowView, let trainingType = workoutRowController.workoutType else {
      return
    }
    
    let configuration = RookTrainingConfiguration(trainingType: trainingType,
                                                  remoteClass: nil)
    showIndividualTraining(trainingConfiguration: configuration)
    
  }
  
  private func showIndividualTraining(trainingConfiguration: RookTrainingConfiguration) {
    WKInterfaceController.reloadRootPageControllers(withNames: ["trainingControlsInterface", "trainingMetricsInterface"],
                                                    contexts: [["trainingConfiguration": trainingConfiguration],
                                                               ["trainingConfiguration": trainingConfiguration]],
                                                    orientation: .horizontal, pageIndex: 1)
  }
  
}
