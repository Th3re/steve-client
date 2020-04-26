//
//  Localizer.swift
//  Steve
//
//  Created by Mateusz Stompór on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import CoreLocation

final class LocationUpdatesSubscription: NSObject, Subscription {
    // MARK: - Properties
    var subscriber: AnySubscriber<CLLocation, Never>
    weak private var publisher: Localizer?
    // MARK: - Initialization
    public init<S: Subscriber>(subscriber: S, publisher: Localizer) where S.Input == CLLocation,
                                                                          S.Failure == Never {
        self.subscriber = AnySubscriber(subscriber)
        self.publisher = publisher
    }
    // MARK: - Subscription
    func request(_ demand: Subscribers.Demand) {
        if demand != .unlimited {
            fatalError("Demand: \(demand) is not supported")
        }
    }
    func cancel() {
        publisher?.finish(subscription: self)
    }
}

final class Localizer: NSObject, Publisher, CLLocationManagerDelegate {
    // MARK: - Aliases
    typealias Output = CLLocation
    typealias Failure = Never
    // MARK: - Properties
    private let manager = CLLocationManager()
    private var subscriptions = [LocationUpdatesSubscription]()
    // MARK: - Initialization
    override init() {
        super.init()
        setupLocationManager()
    }
    // MARK: - Private
    private func setupLocationManager() {
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
        manager.delegate = self
    }
    private func updateTrackingState() {
        if subscriptions.count == 0 {
            manager.stopUpdatingLocation()
        } else if subscriptions.count == 1 {
            manager.startUpdatingLocation()
        }
    }
    // MARK: - Internal
    func finish(subscription: LocationUpdatesSubscription) {
        guard  let index = subscriptions.firstIndex(of: subscription) else {
            return
        }
        subscriptions.remove(at: index)
        updateTrackingState()
    }
    // MARK: - Publisher
    func receive<S>(subscriber: S) where S : Subscriber, Localizer.Failure == S.Failure, Localizer.Output == S.Input {
        let subscription = LocationUpdatesSubscription(subscriber: subscriber, publisher: self)
        subscriptions.append(subscription)
        subscriber.receive(subscription: subscription)
        updateTrackingState()
    }
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        for subscription in self.subscriptions {
            _ = subscription.subscriber.receive(location)
        }
    }
}
