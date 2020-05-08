//
//  SendAuthenticationCodeNetTaskFactory.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct SendAuthenticationCodeNetTaskConfig {
    let code: String
}

class SendAuthenticationCodeNetTaskFactory: NetTaskFactory {
    // MARK: - Aliases
    typealias NetTaskType = SendAuthenticationCodeNetTask
    typealias Config = SendAuthenticationCodeNetTaskConfig
    // MARK: - Properties
    private let serverAddress: String
    // MARK: - Initialization
    init(serverAddress: String) {
        self.serverAddress = serverAddress
    }
    // MARK: - NetTaskFactory
    func build(with config: SendAuthenticationCodeNetTaskConfig) -> SendAuthenticationCodeNetTask {
        return SendAuthenticationCodeNetTask(serverAddress: serverAddress, code: config.code)
    }
}
