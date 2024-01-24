//
//  TrainingViewRepresentable.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI
import CoreBluetooth
import RookMotionSDK

struct TrainingViewRepresentable: UIViewControllerRepresentable {
  
  //typealias UIViewControllerType = UINavigationController
  
  let sensor: CBPeripheral
  let trainingTypeUUID: String
  
  let mainSB = UIStoryboard(name: "Main", bundle: nil)
  
  func makeUIViewController(context: Context) -> UINavigationController {
    let trainingViewController = mainSB.instantiateViewController(identifier: "trainingVC") as! TrainingViewController
    trainingViewController.trainingSensor = sensor
    trainingViewController.training.trainingTypeUUID = trainingTypeUUID
    let navController: UINavigationController = UINavigationController(rootViewController: trainingViewController)
    return navController
  }
  
  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
  }
}

