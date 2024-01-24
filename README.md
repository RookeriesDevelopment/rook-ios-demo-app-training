# RookMotion-IOS-SDK-Sample

This repository contains example projects that show how to integrate the RookMotionLink iOS sdk in you app.

You'll find :

* Install example for Cocoapods dependencies manager
* How to initialize RookMotionSDK in `AppDelegate.swift`
* How to call RookmotionSDK's commands in a ViewController
* How to add a user to RookMotion
* How to start a training

## How to install the IOS SDK in your app?

To install the sdk, you just need to add the following lines in your project Podfile file :

```
 pod 'RookMotionSDK', :git => "https://github.com/RookeriesDevelopment/rook-ios-sdk-training-pod.git"
```

## How to configure the iOS SDK

```
import RookMotionSDK
```

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let clientKey = "YOUR_KEY"
        let tokenLevel = "YOUR_TOKEN"
				let urlBase = "YOUR_BASE_URL"
				let urlRemote = "YOUR_REMOTE_URL"

        RMSettings.shared.setCredentials(client_key: clientKey, token: tokenLevel)
				RMSettings.shared.setUrlApi(with: urlBase)
				RMSettings.shared.setUrlRemote(with: urlRemote)

        return true
    }
```






