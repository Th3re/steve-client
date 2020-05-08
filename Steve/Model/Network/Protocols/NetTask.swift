//
//  NetTask.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine

protocol NetTask {
    // MARK: - Aliases
    associatedtype DataType
    // MARK: - Properties
    var publisher: AnyPublisher<DataType, Error> { get }
}
