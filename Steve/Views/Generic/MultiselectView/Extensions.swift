//
//  Extensions.swift
//  Steve
//
//  Created by Mateusz Stompór on 09/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

extension Array where Element: Selectable {
    mutating func toggleSelected(_ item: Element) {
        if let index = firstIndex(where: { $0.id == item.id }) {
            var mutable = item
            mutable.isSelected.toggle()
            self[index] = mutable
        }
    }
}
