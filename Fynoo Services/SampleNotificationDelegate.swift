//
//  SampleNotificationDelegate.swift
//  NaberMan
//
//  Created by AMBRISH KUMAR PATEL on 05/08/19.
//  Copyright © 2019 Eweblabs. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import UserNotificationsUI


class SampleNotificationDelegate: NSObject  {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
       
        completionHandler([.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(response)
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Open Action")
            NotificationCenter.default.post(name: Notification.Name(Constant.GET_NOTIFICATION), object: response)
        case "Snooze":
            print("Snooze")
        case "Delete":
            print("Delete")
        default:
            print("default")
        }
        completionHandler()
    }
}
