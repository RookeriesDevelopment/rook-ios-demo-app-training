//
//  TrainingTypesView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 31/10/22.
//

import SwiftUI

struct TrainingTypesView: View {
  
  @StateObject var viewModel: TrainingTypesViewModel = TrainingTypesViewModel()
  
  var body: some View {
    
    VStack {
      Text("Training Types")
        .font(.title2)
      
      List(viewModel.trainingTypes,
           id: \.trainingTypeUUID) { training in
        HStack(spacing: 6) {
          Image(systemName: "figure.walk")
          Text(training.trainigName ?? "default")
          Spacer()
        }
        .frame(height: 35)
      }.listStyle(.plain)
        .padding(12)
      
      Spacer()
    }
    .onAppear() {
      viewModel.getTrainingTypes()
    }
    
  }
}

struct TrainingTypesView_Previews: PreviewProvider {
  static var previews: some View {
    TrainingTypesView()
  }
}
