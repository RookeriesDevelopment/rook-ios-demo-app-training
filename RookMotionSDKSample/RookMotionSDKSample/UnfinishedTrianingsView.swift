//
//  PedningTrianingsView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 05/12/22.
//

import SwiftUI
import RookMotionSDK

struct UnfinishedTrianingsView: View {
  
  @ObservedObject var viewModel: PendningTrianingsViewModel = PendningTrianingsViewModel()
  
  var body: some View {
    VStack {
      List {
        
        
        ForEach(viewModel.unisfinishedTrainings, id: \.start) { training in
          
          VStack(alignment: .leading) {
            Text("start \(training.start ?? "")")
            Text("type \(training.trainingTypeUUID ?? "")")
            Text(" current duration \(training.summary?.duration_time_tot ?? 0)")
          }
          
        }
        
        ForEach(viewModel.pendingTrainings, id: \.start) { training in
          
          VStack(alignment: .leading) {
            Text("start \(training.start ?? "")")
            Text("type \(training.trainingTypeUUID ?? "")")
            Text(" current duration \(training.summary?.duration_time_tot ?? 0)")
          }
          
        }
        
      }
    }.onAppear() {
      viewModel.getUnifinishedTrainigns()
      viewModel.getPendingTrainigns()
    }
  }
}

struct PedningTrianingsView_Previews: PreviewProvider {
  static var previews: some View {
    UnfinishedTrianingsView()
  }
}
