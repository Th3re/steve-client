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
    // MARK: - Initialization
    init(localizer: Localizer, accountManager: AccountManager, serverAddress: String) {
        self.serverAddress = serverAddress
        subscription = accountManager.publishers.currentlyLogged
            .combineLatest(localizer)
            .filter{ $0.0 != nil }
            .map{ ($0!, $1)}
            .sink(receiveValue: { userInfo, location in
            self.send(location: location, user: userInfo)
        })
    }
    // MARK: - Private
    private func send(location: CLLocation, user: UserInfo) {
        let url = URL(string: self.serverAddress + "/location/location")!
        let jsonDict: [String : Any] = ["userId": user.userId, "latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error:", error)
                return
            }
            do {
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
            } catch {
                print("error:", error)
            }
        }
        task.resume()
    }
}
