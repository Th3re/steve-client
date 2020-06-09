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
        container.register(CreateMeetingNetTaskFactory.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            return CreateMeetingNetTaskFactory(serverAddress: environment.appConfig.serverAddress)
        }
        container.register(MeetingPointNetTaskFactory.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            return MeetingPointNetTaskFactory(serverAddress: environment.appConfig.serverAddress)
        }
        container.register(ProposeMeetingDateNetTaskFactory.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            return ProposeMeetingDateNetTaskFactory(serverAddress: environment.appConfig.serverAddress)
        }
        container.register(FetchContactsNetTaskFactory.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            return FetchContactsNetTaskFactory(serverAddress: environment.appConfig.serverAddress)
        }
        container.register(SendAuthenticationCodeNetTaskFactory.self) { resolver in
            let environment = resolver.resolve(Environment.self)!
            return SendAuthenticationCodeNetTaskFactory(serverAddress: environment.appConfig.serverAddress)
        }
    }
}
