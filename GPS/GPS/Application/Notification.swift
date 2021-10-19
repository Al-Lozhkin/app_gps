//
//  Notification.swift
//  GPS
//
//  Created by Александр Ложкин on 10.10.2021.
//

import UIKit
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func registerNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted:Bool, error:Error?) in
            if error != nil {
                debugPrint((error?.localizedDescription)!)
                return
            }
            if granted {
                print("permission granted")
            }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    
    //MARK:- UNUserNotification Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //        let dict = response.notification.request.content.userInfo
    }
    
    func scheduleLocalNotification(alert:String) {
        let content = UNMutableNotificationContent()
        let requestIdentifier = UUID.init().uuidString
        
        content.badge = 0
        content.title = "Location Update"
        content.body = alert
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error:Error?) in
            
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            print("Notification Register Success")
        }
    }
}
