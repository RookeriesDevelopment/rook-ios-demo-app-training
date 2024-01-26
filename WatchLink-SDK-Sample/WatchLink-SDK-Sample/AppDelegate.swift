//
//  AppDelegate.swift
//  WatchLink-SDK-Sample
//
//  Created by Francisco Guerrero Escamilla on 19/04/22.
//

import UIKit
import RookMotionSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let urlBase = "" // Your url api
    let clientKey = "" // Your client key
    let token = ""// Your token
    
    RMSettings.shared.setUrlApi(with: urlBase)
    RMSettings.shared.setCredentials(client_key: clientKey, token: token)
    RMSettings.shared.initRookMotionSDK()
    RMCommunicationManager.shared.configureSession()
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
  }
  
  
}

