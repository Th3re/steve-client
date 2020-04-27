//
//  AccountAssembly.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Swinject

struct AccountAssembly: Assembly {
    // MARK: - Assembly
    func assemble(container: Container) {
        container.register(AccountManager.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            let serverAddress = environment.appConfig.serverAddress
            return AccountManager(serverAddress: serverAddress)
        }.inObjectScope(.weak)
        container.register(NotificationManager.self) { resolver in
            let accountManager = resolver.resolve(AccountManager.self)!
            return NotificationManager(accountManager: accountManager)
        }.inObjectScope(.weak)
    }
}
