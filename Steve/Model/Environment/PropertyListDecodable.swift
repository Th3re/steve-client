//
//  PropertyListDecodable.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

protocol PropertyListDecodable {
    associatedtype T
    static func fromPropertyList(name: String) -> T?
}
