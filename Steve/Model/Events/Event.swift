//
//  Event.swift
//  Steve
//
//  Created by Piotr Persona on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct Event: Hashable, Identifiable, Codable {
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
