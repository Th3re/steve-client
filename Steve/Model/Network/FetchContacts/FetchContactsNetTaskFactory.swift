//
//  FetchContactsNetTaskFactory.swift
//  Steve
//
//  Created by Mateusz Stompór on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct FetchContactsNetTaskConfig {
    let userId: String
}


class FetchContactsNetTaskFactory: NetTaskFactory {
    // MARK: - Aliases
    typealias NetTaskType = FetchContactsNetTask
    typealias Config = FetchContactsNetTaskConfig
    // MARK: - Properties
    private let serverAddress: String
    // MARK: - Initialization
    init(serverAddress: String) {
        self.serverAddress = serverAddress
    }
    // MARK: - NetTaskFactory
    func build(with config: FetchContactsNetTaskConfig) -> FetchContactsNetTask {
        return FetchContactsNetTask(serverAddress: serverAddress, userId: config.userId)
    }
}
