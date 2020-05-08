//
//  UserDetailsViewModel.swift
//  Steve
//
//  Created by Mateusz Stompór on 26/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import SwiftUI


class UserDetailsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var name = "Unknown user"
    @Published var email = ""
    @Published var imageURL: URL?
    private let accountManager: AccountManager
    private var userInfo: UserInfo?
    private var subscription: AnyCancellable?
    // MARK: - Initialization
    init(accountManager: AccountManager) {
        self.accountManager = accountManager
        setupSubscription()
    }
    // MARK: - Private
    func setupSubscription() {
        subscription = accountManager.publishers.currentlyLogged.sink(receiveValue: { [unowned self] userInfo in
            if let userInfo = userInfo {
                self.name = userInfo.firstName + " " + userInfo.secondName
                self.email = userInfo.emailAddress
                self.imageURL = userInfo.photoURL
            } else {
                self.name = "Unknown user"
                self.email = ""
                self.imageURL = nil
            }
        })
    }
    // MARK: - Deinitialization
    deinit {
        subscription?.cancel()
    }
}
