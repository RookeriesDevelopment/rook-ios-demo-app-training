//
//  AddUserView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI

struct AddUserView: View {
  
  @ObservedObject var viewModel: AddUserViewModel = AddUserViewModel()
  
  var body: some View {
    VStack {
      Text("Add User")
        .padding(24)
        .font(.title)
      
      VStack {
        TextField("email", text: $viewModel.userEmail)
          .textFieldStyle(.roundedBorder)
          .padding([.leading, .trailing], 18)
          .keyboardType(.emailAddress)
          .onChange(of: viewModel.userEmail,
                    perform: { value in
            viewModel.textFieldValidatorEmail(value)
          })
        if (!viewModel.isValidEmail) {
          Text("Is not valid email")
            .font(.caption)
            .foregroundColor(Color.red)
        }
      }
      
      Button(action: {
        viewModel.addUser()
      }, label: {
        VStack {
          Text("Add")
            .font(.headline)
        }
        .frame(width: 150)
        .padding(12)
        .background(Color.red.opacity(0.5))
        .cornerRadius(12)
        
      })
      Spacer()
    }.alert(isPresented: $viewModel.userAdded) {
      Alert(
        title: Text("Rook"),
          message: Text(viewModel.message)
      )
    }
    .onAppear() {
      viewModel.readUser()
    }
  }
}

struct AddUserView_Previews: PreviewProvider {
  static var previews: some View {
    AddUserView()
  }
}
