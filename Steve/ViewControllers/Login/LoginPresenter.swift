//
//  LoginPresenter.swift
//  Steve
//
//  Created by Mateusz Stompór on 26/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI
import Combine

struct LoginPresenter: UIViewControllerRepresentable {
    // MARK: - Aliases
    typealias UIViewControllerType = LoginViewController
    // MARK: - Properties
    private let accountManager: AccountManageable
    private let loggedUser: UserInfo?
    // MARK: - Initialization
    init(accountManager: AccountManageable, loggedUser: UserInfo?) {
        self.accountManager = accountManager
        self.loggedUser = loggedUser
    }
    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginPresenter>) -> LoginViewController {
        return LoginViewController(accountManager: accountManager, loggedUser: loggedUser)
    }
    func updateUIViewController(_ uiViewController: LoginViewController, context: UIViewControllerRepresentableContext<LoginPresenter>) {
        uiViewController.updateUI()
    }
}
