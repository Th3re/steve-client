//
//  MeetingPointNetTaskFactory.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct MeetingPointNetTaskConfig {
    let window: Window
    let host: String
    let participantIds: [String]
}

class MeetingPointNetTaskFactory: NetTaskFactory {
    // MARK: - Aliases
    typealias NetTaskType = MeetingPointNetTask
    typealias Config = MeetingPointNetTaskConfig
    // MARK: - Properties
    private let serverAddress: String
    // MARK: - Initialization
    init(serverAddress: String) {
        self.serverAddress = serverAddress
    }
    // MARK: - NetTaskFactory
    func build(with config: MeetingPointNetTaskConfig) -> MeetingPointNetTask {
        return MeetingPointNetTask(serverAddress: serverAddress,
                                   host: config.host,
                                   participantIds: config.participantIds,
                                   window: config.window)
    }
}
