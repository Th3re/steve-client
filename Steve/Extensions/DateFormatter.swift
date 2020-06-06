//
//  DateFormatter.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func with(dateFormat: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter
    }
}
