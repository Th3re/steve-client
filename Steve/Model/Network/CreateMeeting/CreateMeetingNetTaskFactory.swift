//
//  CreateMeetingNetTaskFactory.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct CreateMeetingNetTaskConfig {
    let window: Window
    let host: String
    let participantIds: [String]
    let summary: String
    let meetingPoint: String
}

class CreateMeetingNetTaskFactory: NetTaskFactory {
    // MARK: - Aliases
    typealias NetTaskType = CreateMeetingNetTask
    typealias Config = CreateMeetingNetTaskConfig
    // MARK: - Properties
    private let serverAddress: String
    // MARK: - Initialization
    init(serverAddress: String) {
        self.serverAddress = serverAddress
    }
    // MARK: - NetTaskFactory
    func build(with config: CreateMeetingNetTaskConfig) -> CreateMeetingNetTask {
        return CreateMeetingNetTask(serverAddress: serverAddress,
                                    config: config)
    }
}
