//
//  TrainingSummaryView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 31/10/22.
//

import SwiftUI
import RookMotionSDK

struct TrainingSummaryView: View {

  let summaries: RMTrainingSummariesResult?
  
  @Environment(\.presentationMode) var presentationMode
  
  var dismissAction: (() -> Void)
  
  var body: some View {
    VStack {
      
      HStack{
        Spacer()
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        },
               label: {
          Text("Finish")
        })
      }.padding(12)
      
      VStack(spacing: 6) {
        Text("Time info")
        
        HStack() {
          Text("Total time: \(summaries?.totalTimeTraining ?? 0)")
          Spacer()
        }
        
        HStack() {
          Text("Seconds in zone 1: \(Int(summaries?.timeZone1 ?? 0.0)) s")
          Spacer()
        }
        
        HStack() {
          Text("Seconds in zone 2: \(Int(summaries?.timeZone2 ?? 0.0)) s")
          Spacer()
        }
        
        HStack() {
          Text("Seconds in zone 3: \(Int(summaries?.timeZone3 ?? 0.0)) s")
          Spacer()
        }
        
        HStack() {
          Text("Seconds in zone 4: \(Int(summaries?.timeZone4 ?? 0.0)) s")
          Spacer()
        }
        
        HStack() {
          Text("Seconds in zone 5: \(Int(summaries?.timeZone5 ?? 0.0)) s")
          Spacer()
        }
        
      }
      .frame(maxWidth: .infinity)
      .padding(12)
      .background(Color.red.opacity(0.3))
      .cornerRadius(12)
      
      VStack(spacing: 6) {
        Text("Training Info")
        
        HStack {
          Text("Max heart rate \(summaries?.hrMax ?? 0)")
          Spacer()
        }
        
        HStack {
          Text("calories \(summaries?.calories ?? 0)")
          Spacer()
        }
        
        HStack {
          Text("Max effort \(summaries?.effortMax ?? 0)")
          Spacer()
        }
      }
      .frame(maxWidth: .infinity)
      .padding(12)
      .background(Color.red.opacity(0.3))
      .cornerRadius(12)
      
      Spacer()
      
    }.padding(12)
  }
}

struct TrainingSummaryView_Previews: PreviewProvider {
  static var previews: some View {
    
    TrainingSummaryView(summaries: nil,
                        dismissAction: {
    })
  }
}
