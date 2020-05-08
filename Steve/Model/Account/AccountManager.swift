//
//  AccountManager.swift
//  Steve
//
//  Created by Mateusz Stompór on 26/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation


class AccountManager: ObservableObject, AccountManageable {
    // MARK: - Properties
    var publishers: AccountPublishers { AccountPublishers(currentlyLogged: currentlyLoggedUser.eraseToAnyPublisher(),
                                                          previouslyLogged: previouslyLoggedUser.eraseToAnyPublisher())
    }
    var signedUser: UserInfo? { currentlyLoggedUser.value }
    private let currentlyLoggedUser = CurrentValueSubject<UserInfo?, Never>(nil)
    private let previouslyLoggedUser = CurrentValueSubject<UserInfo?, Never>(nil)
    private let netTasksFactory: SendAuthenticationCodeNetTaskFactory
    private var networkTask: AnyCancellable?
    // MARK: - Initialization
    init(netTasksFactory: SendAuthenticationCodeNetTaskFactory) {
        self.netTasksFactory = netTasksFactory
    }
    // MARK: - Internal
    func logOut() {
        changeUser(to: nil)
    }
    func logIn(with userInfo: UserInfo, code: String, completion: @escaping (Bool)->()) {
        networkTask = netTasksFactory.build(with: .init(code: code))
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                completion(false)
            }) { [weak self] data in
            self?.changeUser(to: userInfo)
            completion(true)
        }
    }
    // MARK: - Private
    private func changeUser(to user: UserInfo?) {
        previouslyLoggedUser.send(currentlyLoggedUser.value)
        currentlyLoggedUser.send(user)
    }
    // MARK: - Deinitialization
    deinit {
        networkTask?.cancel()
    }
}
