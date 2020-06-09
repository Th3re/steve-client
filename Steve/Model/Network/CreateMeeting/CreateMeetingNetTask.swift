//
//  CreateMeetingNetTask.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class CreateMeetingNetTask: NetTask {
    // MARK: - Aliases
    typealias DataType = Bool
    // MARK: - Properties
    private let serverAddress: String
    private let config: CreateMeetingNetTaskConfig
    private var url: URL { URL(string: serverAddress + "/events/meeting/create")! }
    // MARK: - Initialization
    init(serverAddress: String, config: CreateMeetingNetTaskConfig) {
        self.serverAddress = serverAddress
        self.config = config
    }
    // MARK: - Private
    private func buildBody() -> [String: Any] {
        return ["start": config.window.start.zonedRfc,
                "end": config.window.end.zonedRfc,
                "host": config.host,
                "summary": config.summary,
                "meetingPoint": config.meetingPoint,
                "participants": config.participantIds] as [String : Any]
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<Bool, Error> {
        let body = buildBody()
        let data = try! JSONSerialization.data(withJSONObject: body, options: [])
        let request = URLRequest.post(url: url, body: data)
        print("Creating meeting with body \(body)")
        return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap {
            let object = try JSONSerialization.jsonObject(with: $0.data, options: []) as! [String: AnyObject]
            return (object["code"] as? String) == "OK"
        }
        .eraseToAnyPublisher()
    }
}
