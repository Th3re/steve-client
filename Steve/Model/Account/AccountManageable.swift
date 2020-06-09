//
//  AccountManageable.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

struct AccountPublishers {
    var currentlyLogged: AnyPublisher<UserInfo?, Never>
    var previouslyLogged: AnyPublisher<UserInfo?, Never>
    var contacts: AnyPublisher<[UserInfo]?, Never>
}

protocol AccountManageable {
    // MARK: - Properties
    var publishers: AccountPublishers { get }
    var signedUser: UserInfo? { get }
    // MARK: - Internal
    func logOut()
    func logIn(with userInfo: UserInfo, code: String, completion: @escaping (Bool)->())
}
