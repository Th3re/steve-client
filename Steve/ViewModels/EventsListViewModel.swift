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
    @Published var eventsList: [Event]
    
    init(eventsFetcher: EventsFetcher) {
        let userId = "108032329945935107776"
        let startTime = "2020-06-07T15:00:00Z"
        let endTime = "2020-06-10T15:00:00Z"
        eventsList = eventsFetcher.fetch(userId: userId, startTime: startTime, endTime: endTime)!
    }
}
