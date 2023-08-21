//
//  AppDelegate.swift
//  leantap
//
//  Created by Shubhansh Rai on 28/07/23.
//

import UIKit
#if DEBUG
    import AdSupport
#endif
import Leanplum
import UserNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
      
    
#if DEBUG
    Leanplum.setDeviceId(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
    Leanplum.setAppId("app_PMtXD9BDoOM9fGR3vMfdTKfkQsaTg9ekHZOza4f0YkI",
                      developmentKey:"dev_Xczg4fOZRaXiZGvwRnyUSyRebOabMHEMboWEDVGRWdk")
  #else
    Leanplum.setAppId("app_PMtXD9BDoOM9fGR3vMfdTKfkQsaTg9ekHZOza4f0YkI",
      withProductionKey: "prod_FcKFwPjFXiB0d7Xc0Ai5miU9b6YHGu6uS8OzW9d9gis")
  #endif
  
  // Sets the app version, which otherwise defaults to
  // the build number (CFBundleVersion).
  Leanplum.setAppVersion("0.2.2")

  // Starts a new session and updates the app content from Leanplum.
  Leanplum.start()
  Leanplum.inbox()
        return true
       }
    
    @available(iOS 10.0, *)
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
         
        let userInfo = response.notification.request.content.userInfo
    // Check if any of the custom actions is executed
            if response.actionIdentifier == "SnoozeAction" || response.actionIdentifier == "EnterAction"
            || response.actionIdentifier == "DismissAction" {
                if let mid = userInfo["_lpn"] as? Int64 { // get the message id
                    // Use the below code to track only the message event without executing an action
                    // You can also use context?.runActionNamed(action)
                    //let ct = Leanplum.createActionContext(forMessageId: String(mid))
                    //let action = response.actionIdentifier.replacingOccurrences(of: "Action", with: "")
                    //ct?.trackMessageEvent(action, withValue: 0, andInfo: "", andParameters: nil)
                     
                    var args = [AnyHashable:Any]()
                    let action = response.actionIdentifier.replacingOccurrences(of: "Action", with: "")
                    if let actions = userInfo[LP_KEY_PUSH_CUSTOM_ACTIONS] as? [AnyHashable:Any] { // access the custom actions _lpc
                        args[action] = actions[action]
                    }
                    let context = ActionContext.init(name: LP_PUSH_NOTIFICATION_ACTION, args: args, messageId: String(mid)) // Init the context with the arguments, messageId and the reserved name - __Push Notification
                    context.runTrackedAction(name: action) // Execute the Action and track the message event
                }
            }
             
            completionHandler()
        }
    func application(_ application: UIApplication,
                             didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                             fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            completionHandler(.newData)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *){
                let userNotifCenter = UNUserNotificationCenter.current()

                userNotifCenter.requestAuthorization(options: [.badge,.alert,.sound]){ (granted,error) in
                    //Handle individual parts of the granting here.

                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            }
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

