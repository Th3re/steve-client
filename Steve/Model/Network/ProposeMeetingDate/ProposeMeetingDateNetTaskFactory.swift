//
//  ProposeMeetingDateNetTaskFactory.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct ProposeMeetingDateNetTaskConfig {
    let date: Date
    let participantsIds: [String]
}


class ProposeMeetingDateNetTaskFactory: NetTaskFactory {
    // MARK: - Aliases
    typealias NetTaskType = ProposeMeetingDateNetTask
    typealias Config = ProposeMeetingDateNetTaskConfig
    // MARK: - Properties
    private let serverAddress: String
    // MARK: - Initialization
    init(serverAddress: String) {
        self.serverAddress = serverAddress
    }
    // MARK: - NetTaskFactory
    func build(with config: ProposeMeetingDateNetTaskConfig) -> ProposeMeetingDateNetTask {
        return ProposeMeetingDateNetTask(serverAddress: serverAddress, participantIds: config.participantsIds, date: config.date)
    }
}
