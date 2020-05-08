//
//  LocationAssembly.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Swinject

struct LocationAssembly: Assembly {
    // MARK: - Assembly
    func assemble(container: Container) {
        container.register(LocationUploader.self) { resolver in
            let localizer = resolver.resolve(Localizer.self)!
            let accountManager = resolver.resolve(AccountManageable.self)!
            let environment = resolver.resolve(Environment.self)!
            let serverAddress = environment.appConfig.serverAddress
            return LocationUploader(localizer: localizer, accountManager: accountManager, serverAddress: serverAddress)
        }
        container.register(Localizer.self) { _ in
            return Localizer()
        }.inObjectScope(.weak)
    }
}
