//
//  SceneDelegate.swift
//  Steve
//
//  Created by Piotr Persona on 15/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import UIKit
import SwiftUI
import Swinject

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties
    var window: UIWindow?
    private let assembler = Assembler.default
    private var locationUploader: LocationUploader?
    private var notificationManager: NotificationManager?
    // MARK: - UIWindowSceneDelegate
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let accountManager = assembler.resolver.resolve(AccountManageable.self)!
        let localizer = assembler.resolver.resolve(Localizer.self)!
        notificationManager = assembler.resolver.resolve(NotificationManager.self)!
        notificationManager?.requestAuthorization()
        locationUploader = assembler.resolver.resolve(LocationUploader.self)!
        let contentView = MainView()
            .environmentObject(UserDetailsViewModel(accountManager: accountManager))
            .environmentObject(AccountViewModel(accountManager: accountManager))
            .environmentObject(CurrentLocationViewModel(localizer: localizer))
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = UIHostingController(rootView: contentView)
            window?.makeKeyAndVisible()
        }
    }
}

