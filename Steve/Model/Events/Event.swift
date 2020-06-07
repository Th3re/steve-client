//
//  Event.swift
//  Steve
//
//  Created by Piotr Persona on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct Event: Hashable, Identifiable, Codable {
//    "end_time": "2020-06-03T23:00:00+0200",
//    "html_link": "https://www.google.com/calendar/event?eid=NXJoOHEzcnBjMDhnMXFrcTdkMDRnN2tiMmkgcGVyc29uYS5waW90ckBnb29nbGVtYWlsLmNvbQ",
//    "identifier": "5rh8q3rpc08g1qkq7d04g7kb2i",
//    "location": "Starowiślna 87, 33-332 Kraków, Poland",
//    "start_time": "2020-06-03T22:00:00+0200",
//    "status": "confirmed",
//    "summary": "Prev event"
    var id: String
    let summary: String
    let location: String
    let htmlLink: String
    let status: String
    let startTime: String
    let endTime: String

    private enum CodingKeys: String, CodingKey {
        case id = "identifier"
        case summary
        case location
        case htmlLink = "html_link"
        case status
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
