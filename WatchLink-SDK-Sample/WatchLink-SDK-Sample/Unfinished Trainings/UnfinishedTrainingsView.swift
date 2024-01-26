//
//  UnfinishedTrainings.swift
//  WatchLink-SDK-Sample
//
//  Created by Francisco Guerrero Escamilla on 07/12/22.
//

import SwiftUI
import RookMotionSDK

struct UnfinishedTrainingsView: View {
  
  @ObservedObject var viewModel: UnfinishedTrainignsViewModel = UnfinishedTrainignsViewModel()
  
  var body: some View {
    VStack {
      Text("Unfinished Trainigns")
      
      List {
        
        ForEach(viewModel.unfinishTrainings,
                id: \.start) { t in
          HStack {
            
            VStack(alignment: .leading) {
              Text("start: \(t.start ?? "")")
              
              Text("duration: \(t.summary?.duration_time_tot ?? 0)")
              
              Text("hrRecords: \(t.records?.hrDerivedRecords.count ?? 0)")
              
              Text("end: \(t.end ?? "")")
            }
            
            Spacer()
          }
          
        }
        
      }
      
    }.onAppear() {
      viewModel.getUnfinishedTrainigs()
    }
  }
}

struct UnfinishedTrainings_Previews: PreviewProvider {
  static var previews: some View {
    UnfinishedTrainingsView()
  }
}
