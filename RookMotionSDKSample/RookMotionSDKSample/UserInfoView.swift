//
//  UserInfoView.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI

struct UserInfoView: View {
  
  @ObservedObject var viewModel: UserInfoViewModel = UserInfoViewModel()
  
  var body: some View {
    VStack {
     
     Text("User Info")
        .font(.title)
        .padding(12)
      
      if (viewModel.isUserStored) {
        UserView(user: viewModel.user)
      } else {
        Text("First add a user and update its information")
      }
      
      Spacer()
    }.onAppear() {
      viewModel.getUserInfo()
    }
  }
}

struct UserView: View {
  
  let user: RookUserInfo?
  
  var body: some View {
    VStack(spacing: 8) {
      HStack {
        Text("User \(user?.name ?? "")")
        Spacer()
      }
      
      HStack {
        Text("Email: \(user?.email ?? "")")
        Spacer()
      }
      
      HStack {
        Text("Birthday: \(user?.birthday ?? "")")
        Spacer()
      }
      
      HStack {
        Text("Sex: \(user?.sex ?? "")")
        Spacer()
      }
      
      HStack {
        Text("pseudonym: \(user?.pseudonym ?? "")")
        Spacer()
      }
      
      HStack {
        Text("Weight: \(user?.weight ?? "")")
        Spacer()
      }
      
      HStack {
        Text("Height: \(user?.height ?? "")")
        Spacer()
      }
      
      HStack {
        Text("Resting Hr: \(user?.restingHeartRate ?? "")")
        Spacer()
      }
        
    }
    .padding(12)
    .frame(maxWidth: .infinity)
    .background(Color.red.opacity(0.6))
    .cornerRadius(12)
    .padding(8)
  }
}

struct UserInfoView_Previews: PreviewProvider {
  static var previews: some View {
    UserInfoView()
  }
}
