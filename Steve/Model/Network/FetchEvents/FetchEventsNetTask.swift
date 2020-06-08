//
//  FetchEventsNetTask.swift
//  Steve
//
//  Created by Piotr Persona on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

struct EventsResponse: Hashable, Decodable {
    let code: String
    let message: String
    let events: [Event]
}

class FetchEventsNetTask: NetTask {
    
    typealias DataType = [Event]
    
    private let eventsAPIAddress: String
    private let userId: String
    private let startTime: String
    private let endTime: String
    
    init(eventsAPIAddress: String, userId: String, startTime: String, endTime: String) {
        self.eventsAPIAddress = "\(eventsAPIAddress)/events/events/\(userId)"
        self.userId = userId
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var publisher: AnyPublisher<[Event], Error> {
        let url = URL(string: self.eventsAPIAddress)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try? JSONSerialization.data(withJSONObject: [
            "startTime": self.startTime,
            "endTime": self.endTime,
        ])

        return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap {
            let responseJSON = try? JSONDecoder().decode(EventsResponse.self, from: $0.data)
            if let eventsResponse = responseJSON {
                return eventsResponse.events
            }
            return []
        }
        .eraseToAnyPublisher()
    }
}
