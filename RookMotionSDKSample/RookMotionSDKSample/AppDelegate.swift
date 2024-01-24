//
//  AppDelegate.swift
//  RookMotionSDKSample
//
//  Created by Francisco Guerrero Escamilla on 15/03/22.
//

import UIKit
import RookMotionSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let urlBase = "https://api2.rookmotion.review" // Your url api
        let clientKey = "Bearer " // Your client key
        let token = "" // Your token
        
        RMSettings.shared.setUrlApi(with: urlBase)
        RMSettings.shared.setCredentials(client_key: clientKey, token: token)
        RMSettings.shared.initRookMotionSDK()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

