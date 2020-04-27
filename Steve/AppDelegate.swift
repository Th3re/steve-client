//
//  AppDelegate.swift
//  Steve
//
//  Created by Piotr Persona on 15/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Firebase
import Swinject
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    private let assembler = Assembler.default
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let environment = assembler.resolver.resolve(Environment.self)!
        GIDSignIn.sharedInstance().clientID = environment.googleConfig.clientId
        GIDSignIn.sharedInstance().serverClientID = environment.googleConfig.serverClientId
        InstanceID.instanceID().instanceID { _, error in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          }
        }
        application.registerForRemoteNotifications()
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}
