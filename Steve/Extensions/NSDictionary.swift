//
//  NSDictionary.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

extension NSDictionary {
    static func fromPropertyList(name: String) -> NSDictionary? {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else {
            return nil
        }
        return NSDictionary(contentsOfFile: path)
    }
}
