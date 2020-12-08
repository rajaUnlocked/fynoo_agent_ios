//
//  AppDelegate.swift
//  Fynoo Services
//
//  Created by Aishwarya on 03/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
//    var agentSignUPModal = AgentSignUPModal()
//     var personalAgentSignUPModal = PersonalAgentSignUPModal()
     var selectServiceStr:String = ""


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        GMSServices.provideAPIKey("AIzaSyAgZ0AyOGQLcv7loggrrhrPXfPm-jsHguY")
        GMSPlacesClient.provideAPIKey("AIzaSyAgZ0AyOGQLcv7loggrrhrPXfPm-jsHguY")
          FirebaseApp.configure()
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


}

