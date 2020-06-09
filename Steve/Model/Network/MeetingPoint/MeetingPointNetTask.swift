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
    private let config: MeetingPointNetTaskConfig
    private var url: URL { URL(string: serverAddress + "/events/meeting/point")! }
    // MARK: - Initialization
    init(serverAddress: String, config: MeetingPointNetTaskConfig) {
        self.serverAddress = serverAddress
        self.config = config
    }
    // MARK: - Private
    private func buildBody() -> [String : Any] {
        return ["start": config.window.start.zonedRfc,
                "end": config.window.end.zonedRfc,
                "host": config.host,
                "participants": config.participantIds] as [String : Any]
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<[Place], Error> {
        let data = try! JSONSerialization.data(withJSONObject: buildBody(), options: .prettyPrinted)
        let request = URLRequest.post(url: url, body: data)
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
