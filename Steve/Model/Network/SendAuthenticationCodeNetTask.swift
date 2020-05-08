//
//  SendAuthenticationCodeNetTask.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation


class SendAuthenticationCodeNetTask: NetTask {
    // MARK: - Aliases
    typealias DataType = [String: AnyObject]
    // MARK: - Properties
    private let serverAddress: String
    private let code: String
    private var url: URL { return URL(string: serverAddress + "/auth/auth?code=\(code)&scope=none")! }
    // MARK: - Initialization
    init(serverAddress: String, code: String) {
        self.serverAddress = serverAddress
        self.code = code
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<[String : AnyObject], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { try JSONSerialization.jsonObject(with: $0.data, options: []) as! [String:AnyObject] }
        .eraseToAnyPublisher()
    }
}
