//
//  TrainingSensorSelector.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI
import CoreBluetooth

struct TrainingSensorSelector: View {
  @StateObject var viewModel: SensorScannerViewModel = SensorScannerViewModel()
  
  var body: some View {
    VStack {
      if (viewModel.isUserStored()) {
        SensorSelectorView(viewModel: viewModel)
          .fullScreenCover(isPresented: $viewModel.isTrainingListActive, content: {
            TrainingTypeSelectorView(sensorViewModel: viewModel)
          })
      } else {
        Text("First add a user")
      }
    }
  }
}


struct SensorSelectorView: View {
  
  @StateObject var viewModel: SensorScannerViewModel
  
  var body: some View {
    GeometryReader { context in
      VStack {
        List {
          ForEach(viewModel.peripheralList, id: \.name) { sensor in
            SensorSelectorViewCell(sensor: sensor, trainingUUID: viewModel.trainingUUID ?? "")
          }
        }.frame(maxHeight: context.size.height * 0.5)
        
        Button(action: {
          viewModel.scan()
        }, label: {
          Text(viewModel.buttonTitle)
            .foregroundColor(Color("colorText"))
            .padding(12)
            .frame(width: 150)
            .background(Color.red.opacity(0.6))
            .cornerRadius(12)
        })
        
        Spacer()
      }
    }.onAppear() {
      viewModel.initScanner()
    }
    .onDisappear() {
      viewModel.releaseResources()
    }
  }
}

struct SensorSelectorViewCell: View {
  
  let sensor: CBPeripheral
  let trainingUUID: String
  
  @State var showTrainingSheet: Bool = false
  
  var body: some View {
    Button(action: {
      showTrainingSheet = true
    }, label: {
      HStack {
        Image(systemName: "antenna.radiowaves.left.and.right")
          .font(.headline)
        Text(sensor.name ?? "")
      }
    }).fullScreenCover(isPresented: $showTrainingSheet) {
      TrainingView(viewModel: TrainingViewModel(sensor: sensor, trainingTypeUUID: trainingUUID), isTrainingViewActive: $showTrainingSheet)
    }
    
  }
}

struct TrainingSensorSelector_Previews: PreviewProvider {
  static var previews: some View {
    TrainingSensorSelector()
  }
}
