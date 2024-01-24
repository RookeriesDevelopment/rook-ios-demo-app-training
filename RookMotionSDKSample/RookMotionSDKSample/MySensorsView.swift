//
//  MySensorsView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 20/04/23.
//

import SwiftUI

struct MySensorsView: View {
  
  @ObservedObject var viewModel: MySensorViewModel = MySensorViewModel()
  
  var body: some View {
    VStack {
      
      Text("My sensors")
        .font(.system(size: 24, weight: .black))
        .padding(12)
      
      
      List {
        ForEach(viewModel.userSensors) { sensor in
          Text(sensor.name)
        }
        .onDelete() { indexes in
          viewModel.deleteSensor(sensor: indexes)
        }
      }
      
      Spacer()
      
    }.onAppear() {
      viewModel.getUserSensor()
    }
  }
}

struct MySensorsView_Previews: PreviewProvider {
  static var previews: some View {
    MySensorsView()
  }
}
