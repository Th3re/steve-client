//
//  SelectParticipantsViewModel.swift
//  Steve
//
//  Created by Mateusz Stompór on 09/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

struct ContactEntry: Selectable {
    var name: String { contact.emailAddress }
    var id: String { self.name }
    var contact: UserInfo
    var isSelected: Bool = false
}

class SelectParticipantsViewModel: ObservableObject {
    // MARK: - Properties
    @Published var connections = [ContactEntry]()
    private var subscription: Cancellable?
    private let accountManager: AccountManageable
    // MARK: - Initialization
    init(accountManager: AccountManageable) {
        self.accountManager = accountManager
        setupSubscription()
    }
    // MARK: - Private
    func setupSubscription() {
        subscription = accountManager.publishers.contacts.sink(receiveValue: { [weak self] contacts in
            var allContacts = [ContactEntry]()
            if let signedUser = self?.accountManager.signedUser {
                allContacts.append(ContactEntry(contact: signedUser))
            }
            if let contacts = contacts {
                allContacts.append(contentsOf: contacts.map {ContactEntry(contact: $0) })
            }
            self?.connections = allContacts
        })
    }
    // MARK: - Deinitialization
    deinit {
        subscription?.cancel()
    }
}
