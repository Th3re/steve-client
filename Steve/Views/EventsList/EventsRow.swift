//
//  EventsRow.swift
//  Steve
//
//  Created by Piotr Persona on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct EventsRow: View {
    var event: Event
    
    func eventTime(_ event: Event) -> String {
        let eventStart = event.startTimeDate()
        let eventEnd = event.endTimeDate()
        
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "d MMM, HH:mm"
        let start = startDateFormatter.string(from: eventStart)
        
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "HH:mm"
        let end = endDateFormatter.string(from: eventEnd)
        return "\(start)-\(end)"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.summary)
            .font(.title)
            Text(self.eventTime(event))
            .font(.caption)
            Text(event.location)
            .font(.caption)
        }
    }
}

struct EventsRow_Previews: PreviewProvider {
    static var previews: some View {
        EventsRow(event: event)
    }
}

var event = Event(
    id: "5rh8q3rpc08g1qkq7d04g7kb2i",
    summary: "Prev event",
    location: "Starowiślna 87, 33-332 Kraków, Poland",
    htmlLink: "https://www.google.com/calendar/event?eid=NXJoOHEzcnBjMDhnMXFrcTdkMDRnN2tiMmkgcGVyc29uYS5waW90ckBnb29nbGVtYWlsLmNvbQ",
    status: "confirmed",
    startTime: "2020-06-03T21:00:00+0200",
    endTime: "2020-06-03T23:00:00+0200"
)
