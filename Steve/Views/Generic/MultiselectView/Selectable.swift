//
//  Selectable.swift
//  Steve
//
//  Created by Mateusz Stompór on 09/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

protocol Selectable: Identifiable {
    // MARK: - Properties
    var name: String { get }
    var isSelected: Bool { get set }
}
