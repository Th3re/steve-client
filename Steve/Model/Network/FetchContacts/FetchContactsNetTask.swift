//
//  FetchContactsNetTask.swift
//  Steve
//
//  Created by Mateusz Stompór on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class FetchContactsNetTask: NetTask {
    // MARK: - Aliases
    typealias DataType = [UserInfo]
    // MARK: - Properties
    private let serverAddress: String
    private let userId: String
    private var url: URL { URL(string: serverAddress + "/auth/contacts/\(userId)")! }
    // MARK: - Initialization
    init(serverAddress: String, userId: String) {
        self.serverAddress = serverAddress
        self.userId = userId
    }
    // MARK: - NetTask
    var publisher: AnyPublisher<[UserInfo], Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        .tryMap {
            let object = try JSONSerialization.jsonObject(with: $0.data, options: []) as! [String: [[String: String]]]
            let contacts = object["contacts"]! as [[String: String]]
            var result = [UserInfo]()
            for contact in contacts {
                result.append(UserInfo(userId: contact["user_id"]!,
                                       photoURL: nil,
                                       emailAddress: contact["email"]!,
                                       firstName: "",
                                       secondName: ""))
            }
            return result
        }
        .eraseToAnyPublisher()
    }
}
