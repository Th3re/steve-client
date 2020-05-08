//
//  NotificationManager.swift
//  Steve
//
//  Created by Mateusz Stompór on 27/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Firebase

class NotificationManager: NSObject, UNUserNotificationCenterDelegate, MessagingDelegate {
    // MARK: - Properties
    private let accountManager: AccountManageable
    private var currentUserSubscription: Cancellable?
    private var previousUserSubscription: Cancellable?
    // MARK: - Initialization
    init(accountManager: AccountManageable) {
        self.accountManager = accountManager
        super.init()
        setupDelegates()
        setupSubscriptions()
    }
    // MARK: - Private
    private func setupDelegates() {
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
    }
    private func setupSubscriptions() {
        currentUserSubscription = accountManager.publishers.currentlyLogged.compactMap { $0 }.sink { user in
            Messaging.messaging().subscribe(toTopic: user.userId)
        }
        previousUserSubscription = accountManager.publishers.previouslyLogged.compactMap { $0 }.sink { user in
            Messaging.messaging().unsubscribe(fromTopic: user.userId)
        }
    }
    // MARK: - Internal
    func requestAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: {_, _ in })
    }
    // MARK: - MessagingDelegate
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: ["token": fcmToken])
    }
    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.sound,.alert])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    // MARK: - Deinitialization
    deinit {
        previousUserSubscription?.cancel()
        currentUserSubscription?.cancel()
    }
}
