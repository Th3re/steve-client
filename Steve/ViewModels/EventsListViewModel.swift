//
//  EventsListViewModel.swift
//  Steve
//
//  Created by Piotr Persona on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class EventsListViewModel: ObservableObject {
    @Published var eventsList: [Event] = []
    private var serverAddress: String
    private var userInfo: UserInfo?
    private var eventsTaskSubscription: AnyCancellable?
    private var userInfoSubscription: AnyCancellable?
    private var accountManager: AccountManageable
    
    init(serverAddress: String, accountManager: AccountManageable) {
        self.serverAddress = serverAddress
        self.accountManager = accountManager
        setupSubscription()
    }
    
    private func endRangeInterval(start: Date) -> Date? {
        var interval = DateComponents()
        interval.month = 1
        return Calendar.current.date(byAdding: interval, to: start)
    }
    
    func setupSubscription() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dTHH:mm:ssZ"
        let now = Date()
        let startTime = dateFormatter.string(from: now)
        let endTime = dateFormatter.string(from: self.endRangeInterval(start: now)!)
//        userInfoSubscription = self.accountManager
//            .publishers
//            .currentlyLogged
//            .receive(on: DispatchQueue.main)
//            .assign(to: \.userInfo, on: self)
        eventsTaskSubscription = FetchEventsNetTask(
            eventsAPIAddress: self.serverAddress,
            userId: "108032329945935107776",
            startTime: startTime,
            endTime: endTime
            )
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }) { (events) in
                self.eventsList = events
            }
    }
    
    deinit {
        eventsTaskSubscription?.cancel()
        userInfoSubscription?.cancel()
    }
}
