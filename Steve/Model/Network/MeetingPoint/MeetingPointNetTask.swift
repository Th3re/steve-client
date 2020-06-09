//
//  MeetingPointNetTask.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import MapKit
import Combine
import Foundation

class MeetingPointNetTask: NetTask {
    // MARK: - Aliases
    typealias DataType = [Place]
    // MARK: - Properties
    private let serverAddress: String
    private let host: String
    private let participantIds: [String]
    private let window: Window
    private var url: URL { URL(string: serverAddress + "/events/meeting/point")! }
    // MARK: - Initialization
    init(serverAddress: String, host: String, participantIds: [String], window: Window) {
        self.serverAddress = serverAddress
        self.host = host
        self.participantIds = participantIds
        self.window = window
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<[Place], Error> {
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        let body = ["start": window.start.zonedRfc,
                    "end": window.end.zonedRfc,
                    "host": host,
                    "participants": participantIds] as [String : Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
        .tryMap {
            let object = try JSONSerialization.jsonObject(with: $0.data, options: []) as! [String: AnyObject]
            if let places = object["meetingPoints"] as? [[String: Any]] {
                var result = [Place]()
                for place in places {
                    let coordinates = place["coordinates"] as! [String: Double]
                    let location = CLLocationCoordinate2D(latitude: coordinates["latitude"]!, longitude: coordinates["longitude"]!)
                    result.append(Place(address: place["address"] as! String, location: location))
                }
                return result
            }
            return []
        }
        .eraseToAnyPublisher()
    }
}
