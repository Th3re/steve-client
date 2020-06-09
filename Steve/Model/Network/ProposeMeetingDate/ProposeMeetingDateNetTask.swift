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
    private let config: ProposeMeetingDateNetTaskConfig
    private var url: URL { URL(string: serverAddress + "/events/meeting/date")! }
    // MARK: - Initialization
    init(serverAddress: String, config: ProposeMeetingDateNetTaskConfig) {
        self.serverAddress = serverAddress
        self.config = config
    }
    // MARK: - Private
    private func buildBody() -> [String: Any] {
        return ["date": DateFormatter.yearMonthDay.string(from: config.date),
                "participants": config.participantsIds]
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<[Window], Error> {
        let data = try! JSONSerialization.data(withJSONObject: buildBody(), options: [])
        let request = URLRequest.post(url: url, body: data)
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
