//
//  TrainingView.swift
//  RookTrainingSDKDemoApp
//
//  Created by Francisco Guerrero Escamilla on 01/08/24.
//

import SwiftUI

struct TrainingView: View {

  @StateObject var viewModel: TrainingViewModel
  @Binding var isTrainingViewActive: Bool
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack {
          Text("Training")
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 24)
          
          HStack {
            Text("Sensor Connected:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Text(viewModel.sensorName)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Battery:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Text(viewModel.battery)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Duration:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Text(viewModel.duration)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Metrics:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Heart rate:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Spacer()
            Text(viewModel.heartRate)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Steps")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Spacer()
            Text(viewModel.steps)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Calories:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Spacer()
            Text(viewModel.calories)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            Text("Effort:")
              .fontWeight(.bold)
              .padding(.leading, 12)
              .padding([.top], 24)
            Spacer()
            Text(viewModel.effort)
              .padding(.leading, 4)
              .padding([.top], 24)
            Spacer()
          }
          
          HStack {
            
            if viewModel.isButtonStopActive {
              Spacer()
              
              Button(action: {
                viewModel.stopTraining()
              }, label: {
                Text("Stop")
              })
            }
            
            
            Spacer()
            Button(action: {
              viewModel.startTraining()
            }, label: {
              Text("Start")
            })
            Spacer()
          }
          .padding(32)
          
          NavigationLink(isActive: $viewModel.isSummaryViewActive) {
            TrainingSummaryView(summaries: viewModel.trainingEndResponse?.trainingSummaries) {
              isTrainingViewActive = false
            }.navigationBarBackButtonHidden()
          } label: {
            EmptyView()
          }
        }.onAppear() {
          viewModel.onAppear()
        }
      }
    }
  }
}
