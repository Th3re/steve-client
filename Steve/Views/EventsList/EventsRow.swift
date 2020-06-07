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
    
    var body: some View {
        HStack {
            Text(event.startTime)
            Text(event.summary)
                .font(.title)
            
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
    startTime: "2020-06-03T22:00:00+200",
    endTime: "2020-06-03T23:00:00+0200"
)
