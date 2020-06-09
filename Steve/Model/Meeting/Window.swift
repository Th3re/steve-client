//
//  Window.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct Window: Identifiable {
    // MARK: - Properties
    var start: Date
    var end: Date
    // MARK: - Identifiable
    var id: Int {
        return start.hashValue ^ end.hashValue
    }
}
