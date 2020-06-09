//
//  LocationUploader.swift
//  Steve
//
//  Created by Mateusz Stompór on 27/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation
import CoreLocation

class LocationUploader {
    // MARK: - Properties
    private var subscription: Cancellable?
    private let serverAddress: String
    private var url: URL {
        URL(string: serverAddress + "/location/location")!
    }
    // MARK: - Initialization
    init(localizer: Localizer, accountManager: AccountManageable, serverAddress: String) {
        self.serverAddress = serverAddress
        subscription = accountManager.publishers.currentlyLogged
            .combineLatest(localizer)
            .filter{ $0.0 != nil }
            .map{ ($0!, $1)}
            .sink(receiveValue: { [unowned self] userInfo, location in
            self.send(location: location, user: userInfo)
        })
    }
    // MARK: - Private
    private func send(location: CLLocation, user: UserInfo) {
        let data: [String : Any] = ["userId": user.userId,
                                    "latitude": location.coordinate.latitude,
                                    "longitude": location.coordinate.longitude]
        let body = try! JSONSerialization.data(withJSONObject: data, options: [])
        let request = URLRequest.post(url: url, body: body)
        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                print("error:", error)
                return
            }
        }
        task.resume()
    }
}
