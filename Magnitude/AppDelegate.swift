//
//  AppDelegate.swift
//  Magnitude
//
//  Created by admin on 6/17/21.
//

import UIKit
import Firebase
import AppsFlyerLib


@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate {
  
var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    FirebaseApp.configure()
    AppsFlyerLib.shared().appsFlyerDevKey = "xPkhypZfhF8Afqr2a5REa5"
    AppsFlyerLib.shared().appleAppID = "1566867993"
    AppsFlyerLib.shared().delegate = self
    NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  @objc func sendLaunch() {
      AppsFlyerLib.shared().start()
  }
  func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
    
  }
  
  func onConversionDataFail(_ error: Error) {
    
  }
}

