//
//  UpdateUserInfoView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI

struct UpdateUserInfoView: View {
  
  @ObservedObject var viewModel: UpdateUserInfoViewModel = UpdateUserInfoViewModel()
  
  var body: some View {
    VStack {
      Text("Update User info")
        .font(.title2)
      if (viewModel.isUserStored()) {
        UpdateUserForm(viewModel: viewModel)
      } else {
        Text("First add a user")
      }
      
      Spacer()
    }.onAppear() {
      viewModel.readUserInfo()
    }
    
  }
}

struct UpdateUserForm: View {
  @ObservedObject var viewModel: UpdateUserInfoViewModel
  
  var body: some View {
    Form {
      
      Section(header: Text("User basic information")) {
        
        TextField("User name", text: $viewModel.userName)
        
        TextField("Lastname", text: $viewModel.lastName)
        
        TextField("LastName 2", text: $viewModel.lastName2)
        
        TextField("Pseudonym", text: $viewModel.pseudonym)
        
        DatePicker("Birthday", selection: $viewModel.birdthday, in: ...Date(), displayedComponents: .date)
        
        Picker("Gender", selection: $viewModel.sex) {
          ForEach(viewModel.sexOptions, id: \.self) { value in
            Text(value.capitalized)
          }
        }
      }
      
      Section(header: Text("User physical information")) {
        TextField("Height", text: $viewModel.height)
          .keyboardType(.numberPad)
        
        TextField("Weigth", text: $viewModel.weight)
          .keyboardType(.numberPad)
        
        TextField("Resting Hear rate", text: $viewModel.restingHeartRate)
          .keyboardType(.numberPad)
      }
      
    }
    
    Button(action: {
      viewModel.updatedUser()
    }, label: {
      Text("Save")
        .padding(12)
        .frame(width: 150)
        .background(Color.red.opacity(0.6))
        .cornerRadius(12)
    })
    .alert(isPresented: $viewModel.userUpdated) {
      Alert(
        title: Text("Rook"),
        message: Text("User Updated")
      )
    }
  }
}

struct UpdateUserInfoView_Previews: PreviewProvider {
  static var previews: some View {
    UpdateUserInfoView()
  }
}
