//
//  NetTaskFactory.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

protocol NetTaskFactory {
    // MARK: - Aliases
    associatedtype NetTaskType: NetTask
    associatedtype Config
    // MARK: - Internal
    func build(with config: Config) -> NetTaskType
}
