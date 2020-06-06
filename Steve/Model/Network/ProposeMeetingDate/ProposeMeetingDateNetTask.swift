//
//  ProposeMeetingDateNetTask.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class ProposeMeetingDateNetTask: NetTask {
    // MARK: - Aliases
    typealias DataType = [Window]
    // MARK: - Properties
    private let serverAddress: String
    private let participantIds: [String]
    private let date: Date
    private var url: URL { URL(string: serverAddress + "/events/meeting/date")! }
    // MARK: - Initialization
    init(serverAddress: String, participantIds: [String], date: Date) {
        self.serverAddress = serverAddress
        self.participantIds = participantIds
        self.date = date
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<[Window], Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["date": formatter.string(from: date),
                                                                        "participants": participantIds], options: .prettyPrinted)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap {
            let object = try JSONSerialization.jsonObject(with: $0.data, options: []) as! [String: AnyObject]
            let windows = object["dates"]! as! [[String: String]]
            var result = [Window]()
            for window in windows {
                let start = window["start"]!
                let end = window["end"]!
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                result.append(Window(start: dateFormatterGet.date(from: start)!, end: dateFormatterGet.date(from: end)!))
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
