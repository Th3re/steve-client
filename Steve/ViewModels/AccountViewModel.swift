//
//  AccountViewModel.swift
//  Steve
//
//  Created by Mateusz Stompór on 26/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class AccountViewModel: ObservableObject {
    // MARK: - Properties
    @Published var loggedUser: UserInfo?
    let accountManager: AccountManager
    private var subscription: AnyCancellable?
    // MARK: - Initialization
    init(accountManager: AccountManager) {
        self.accountManager = accountManager
        setupSubscription()
    }
    // MARK: - Private
    func setupSubscription() {
        subscription = accountManager.publishers.currentlyLogged.assign(to: \.loggedUser, on: self)
    }
    // MARK: - Deinitialization
    deinit {
        subscription?.cancel()
    }
}
