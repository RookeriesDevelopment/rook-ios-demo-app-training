//
//  HitoryTableController.swift
//  WatchLink-SDK-Sample
//
//  Created by Francisco Guerrero Escamilla on 03/05/22.
//

import UIKit
import RookMotionSDK

class HistoryTableController: UITableViewController {

    //MARK: - Properties
    
    let rmManager = RMClass()
    let apiManager = RMApi()
    let storageManager = RMStorageManager()
    var trainings: [RMTrainingRetrived]? = []
    
    //MARK: - Outlet
    
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTable()
        getUserHistory()
    }
    
    //MARK: - Helpers
    
    private func configureTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    
    private func getUserHistory() {
        let uuid = storageManager.getUserUUID() ?? ""
        apiManager.retrieveTrainingsFromUser(userUUID: uuid) { [weak self] (httpCode, jsonResponse, _) in
          DispatchQueue.main.async {
            autoreleasepool() {
              let workouts = self?.decodeJson(jsonResponse)
              self?.storageManager.getUnfinishedTrainings() { unfinisheTrainings in
                print(unfinisheTrainings)
              }
              self?.trainings = workouts
              self?.tableView.reloadData()
            }
          }
        }
        
    }
    
    private func decodeJson(_ jsonString: String) -> [RMTrainingRetrived]? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        do {
            let trainings = try JSONDecoder().decode([RMTrainingRetrived].self, from: data)
            return trainings
        } catch {
            print(error)
            return nil
        }
                
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let workouts = trainings else { return 0}
        return workouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) 
        if let workout = trainings?[indexPath.row] {
            cell.textLabel?.text = "\(workout.trainingType ?? "") \(workout.start ?? "")"
        }
        return cell
    }

}
