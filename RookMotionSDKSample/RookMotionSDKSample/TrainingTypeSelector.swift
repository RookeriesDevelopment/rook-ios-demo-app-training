//
//  TrainingTypeSelector.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 24/01/24.
//

import Foundation
import SwiftUI
import RookMotionSDK

struct TrainingTypeSelectorView: View {
  
  @StateObject var viewModel: TrainingTypesViewModel = TrainingTypesViewModel()
  @StateObject var sensorViewModel: SensorScannerViewModel
  
  var body: some View {
    
    VStack {
      Text("Training Types")
        .font(.title2)
      
      List(viewModel.trainingTypes,
           id: \.trainingTypeUUID) { training in
        
        Button(action: {
          sensorViewModel.trainingUUID = training.trainingTypeUUID
          sensorViewModel.isTrainingListActive = false
        }, label: {
          HStack(spacing: 6) {
            Image(systemName: "figure.walk")
            Text(training.trainigName ?? "default")
            Spacer()
          }
          .frame(height: 35)
        })
        
      }.listStyle(.plain)
        .padding(12)
      
      Spacer()
    }
    .onAppear() {
      viewModel.getTrainingTypes()
    }
    
  }
}

