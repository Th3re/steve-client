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
    private let host: String
    private let participantIds: [String]
    private let window: Window
    private let summary: String
    private let meetingPoint: String
    private var url: URL { URL(string: serverAddress + "/events/meeting/create")! }
    // MARK: - Initialization
    init(serverAddress: String, host: String, participantIds: [String], window: Window, summary: String, meetingPoint: String) {
        self.serverAddress = serverAddress
        self.host = host
        self.participantIds = participantIds
        self.window = window
        self.summary = summary
        self.meetingPoint = meetingPoint
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<Bool, Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        let body = ["start": window.start.zonedRfc,
                    "end": window.end.zonedRfc,
                    "host": host,
                    "summary": summary,
                    "meetingPoint": meetingPoint,
                    "participants": participantIds] as [String : Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        print("Creating meeting with body \(body)")
        return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap {
            let object = try JSONSerialization.jsonObject(with: $0.data, options: []) as! [String: AnyObject]
            return (object["code"] as? String) == "OK"
        }
        .eraseToAnyPublisher()
    }
}
