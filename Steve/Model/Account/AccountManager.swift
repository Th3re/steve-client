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
                                                          previouslyLogged: previouslyLoggedUser.eraseToAnyPublisher(),
                                                          contacts: contacts.eraseToAnyPublisher())
    }
    var signedUser: UserInfo? { currentlyLoggedUser.value }
    private let currentlyLoggedUser = CurrentValueSubject<UserInfo?, Never>(nil)
    private let previouslyLoggedUser = CurrentValueSubject<UserInfo?, Never>(nil)
    private let contacts = CurrentValueSubject<[UserInfo]?, Never>(nil)
    private let sendAuthenticationNetTaskFactory: SendAuthenticationCodeNetTaskFactory
    private let fetchContactsNetTaskFactory: FetchContactsNetTaskFactory
    private var sendAuthenticationNetworkTask: AnyCancellable?
    private var fetchContactsNetworkTask: AnyCancellable?
    // MARK: - Initialization
    init(sendAuthenticationNetTaskFactory: SendAuthenticationCodeNetTaskFactory, fetchContactsNetTaskFactory: FetchContactsNetTaskFactory) {
        self.sendAuthenticationNetTaskFactory = sendAuthenticationNetTaskFactory
        self.fetchContactsNetTaskFactory = fetchContactsNetTaskFactory
    }
    // MARK: - Internal
    func logOut() {
        changeUser(to: nil)
    }
    func logIn(with userInfo: UserInfo, code: String, completion: @escaping (Bool)->()) {
        sendAuthenticationNetworkTask = sendAuthenticationNetTaskFactory.build(with: .init(code: code))
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                completion(false)
            }) { [weak self] data in
            self?.changeUser(to: userInfo)
                self?.fetchContactsNetworkTask = self?.fetchContactsNetTaskFactory.build(with: .init(userId: userInfo.userId))
               .publisher
               .receive(on: DispatchQueue.main)
               .sink(receiveCompletion: { _ in
               }) { [weak self] data in
                print("Contacts: \(data)")
                self?.contacts.send(data)
           }
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
        sendAuthenticationNetworkTask?.cancel()
        fetchContactsNetworkTask?.cancel()
    }
}
