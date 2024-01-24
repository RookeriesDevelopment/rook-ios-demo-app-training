//
//  UserHome.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 01/11/22.
//

import SwiftUI

struct UserHome: View {
  var body: some View {
    
    List {
      
      NavigationLink(destination: AddUserView(), label: {
        HomeCell(title: "Add User")
      })
      
      NavigationLink(destination: UserInfoView(), label: {
        HomeCell(title: "User info")
      })
      
      NavigationLink(destination: UpdateUserInfoView(), label: {
        HomeCell(title: "Update user info")
      })
      
    }
    
  }
}

struct UserHome_Previews: PreviewProvider {
  static var previews: some View {
    UserHome()
  }
}
