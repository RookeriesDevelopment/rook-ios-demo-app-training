//
//  TrainingHistoryView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 02/11/22.
//

import SwiftUI
import RookMotionSDK

struct TrainingHistoryView: View {
  
  @ObservedObject var viewModel: TrainingHistoryViewModel = TrainingHistoryViewModel()
  
  var body: some View {
    VStack {
      
      Text("User Trainings")
        .font(.title)
        .padding(12)
      
      List {
        ForEach(viewModel.trainings, id: \.trainingUUID) { training in
          TrainingUserCell(training: training)
        }
      }.listStyle(.plain)
      
    }.onAppear() {
      viewModel.getUserTrainings()
      viewModel.uploadPendingTrainigns()
    }
  }
}

struct TrainingUserCell: View {
  
  let training: UserTraining
  
  var body: some View {
    HStack {
      
      VStack {
        Text("Start \(training.start)")
        Text("End \(training.end)")
      }.font(.caption)
      
      VStack {
        Text("Start \(training.trainingType)")
        Text("Calories \(training.summaries.caloriesTot ?? "0")")
      }.font(.caption)
      
      Spacer()
      
      VStack {
        Text("duration \(training.summaries.durationTimeTot ?? "0")")
      }.font(.caption)
    }.background(Color.red.opacity(0.6))
    
  }
  
}

struct TrainingHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    TrainingHistoryView()
  }
}
