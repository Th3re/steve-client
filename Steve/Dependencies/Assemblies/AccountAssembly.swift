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
        container.register(AccountManageable.self) { resolver in
            let sendAuthenticationNetTaskFactory = resolver.resolve(SendAuthenticationCodeNetTaskFactory.self)!
            let fetchContactsNetTaskFactory = resolver.resolve(FetchContactsNetTaskFactory.self)!
            return AccountManager(sendAuthenticationNetTaskFactory: sendAuthenticationNetTaskFactory,
                                  fetchContactsNetTaskFactory: fetchContactsNetTaskFactory)
        }.inObjectScope(.weak)
        container.register(NotificationManager.self) { resolver in
            let accountManager = resolver.resolve(AccountManageable.self)!
            return NotificationManager(accountManager: accountManager)
        }.inObjectScope(.weak)
    }
}
