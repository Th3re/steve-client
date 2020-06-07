//
//  EventsFetcher.swift
//  Steve
//
//  Created by Piotr Persona on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI
import Foundation

struct EventsResponse: Hashable, Decodable {
    let code: String
    let message: String
    let events: [Event]
}

struct EventsFetcher {
    var serverURL: String
    
    func fetch(userId: String, startTime: String, endTime: String) -> [Event]? {
        // prepare json data
        let json: [String: Any] = [
            "startTime": startTime,
            "endTime": endTime,
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "\(serverURL)/events/\(userId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // insert json data to the request
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONDecoder().decode(EventsResponse.self, from: data)
            if let responseJSON = responseJSON {
                print(responseJSON)
                events = responseJSON.events
            }
        }

        task.resume()
        return events
    }
}
