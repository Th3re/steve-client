//
//  NetworkAssembly.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Swinject

class NetworkAssembly: Assembly {
    // MARK: - Assembly
    func assemble(container: Container) {
        container.register(SendAuthenticationCodeNetTaskFactory.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            return SendAuthenticationCodeNetTaskFactory(serverAddress: environment.appConfig.serverAddress)
        }
    }
}
