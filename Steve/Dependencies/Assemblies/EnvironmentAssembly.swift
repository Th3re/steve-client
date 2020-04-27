//
//  EnvironmentAssembly.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Swinject

struct EnvironmentAssembly: Assembly {
    // MARK: - Assembly
    func assemble(container: Container) {
        container.register(Environment.self) { resolver in
            let googleConfig = resolver.resolve(GoogleConfig.self)!
            let appConfig = resolver.resolve(AppConfig.self)!
            return Environment(googleConfig: googleConfig, appConfig: appConfig)
        }
        container.register(GoogleConfig.self) { _ in
            return GoogleConfig.fromPropertyList(name: "GoogleService-Info")!
        }
        container.register(AppConfig.self) { _ in
            return AppConfig.fromPropertyList(name: "Info")!
        }
    }
}
