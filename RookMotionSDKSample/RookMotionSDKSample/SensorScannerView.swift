//
//  SensorScannerView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI

struct SensorScannerView: View {
  
  @ObservedObject var viewModel: SensorScannerViewModel = SensorScannerViewModel()
  
  var body: some View {
    
    GeometryReader { context in
      VStack {
        List {
          ForEach(viewModel.sensorList, id: \.name) { sensor in
            SensorViewCell(sensorName: sensor.name,
                           action: {
              viewModel.addSensorToUser(sensor: sensor.peripheral)
            })
          }
        }.frame(maxHeight: context.size.height * 0.5)
        
        Button(action: {
          viewModel.scan()
        }, label: {
          Text(viewModel.buttonTitle)
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
    .alert(isPresented: $viewModel.sensorAdded) {
      Alert(
        title: Text("Rook"),
          message: Text(viewModel.message)
      )
    }
    .onDisappear() {
      viewModel.releaseResources()
    }
  }
}

struct SensorViewCell: View {
  
  let sensorName: String
  let action: () -> Void
  
  var body: some View {
    
    Button(action: action, label: {
      HStack {
        Image(systemName: "antenna.radiowaves.left.and.right")
          .font(.headline)
        Text(sensorName)
      }
    })
  }
}

struct SensorScannerView_Previews: PreviewProvider {
  static var previews: some View {
    SensorScannerView()
  }
}
