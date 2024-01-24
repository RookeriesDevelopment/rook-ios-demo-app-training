//
//  HomeView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 31/10/22.
//

import SwiftUI

struct HomeView: View {
  
  @State var showTrainingSheet: Bool = false
  
  var body: some View {
    NavigationView {
      
      List {
        NavigationLink(destination: UserHome(), label: {
          HomeCell(title: "User")
        })
        
        NavigationLink(destination: TrainingTypesView(), label: {
          HomeCell(title: "Training Types")
        })
        
        NavigationLink(destination: SensorScannerView(), label: {
          HomeCell(title: "Sensor Scanner")
        })
        
        NavigationLink(destination: MySensorsView(), label: {
          HomeCell(title: "My sensors")
        })
        
        NavigationLink(destination: TrainingHistoryView(), label: {
          HomeCell(title: "Training History")
        })
        
        NavigationLink(destination: TrainingSensorSelector(), label: {
          HomeCell(title: "Training")
        })
        
        NavigationLink(destination: UnfinishedTrianingsView(), label: {
          HomeCell(title: "Unfinshed Trainings")
        })
        
      }
    }
  }
}

struct HomeCell: View {
  
  let title: String
  
  var body: some View {
    HStack {
      Text(title)
        .foregroundColor(Color("colorText"))
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
