//
//  LoginViewController.swift
//  Steve
//
//  Created by Piotr Persona on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import UIKit
import SnapKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate {
    // MARK: - Properties
    private let button = UIButton(type: .system)
    private let accountManager: AccountManageable
    private var buttonTitle: String {
        get {
            accountManager.signedUser != nil ? "Sign out" : "Sign In"
        }
    }
    // MARK: - Initialization
    init(accountManager: AccountManageable, loggedUser: UserInfo?) {
        self.accountManager = accountManager
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        setupAppearance()
        updateUI()
    }
    // MARK: - Overriden
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = view.bounds.height/2.0
    }
    // MARK: - Internal
    func updateUI() {
        button.setTitle(buttonTitle, for: .normal)
    }
    // MARK: - Private
    @objc private func tapped(_ sender: UIButton) {
        if accountManager.signedUser != nil {
            GIDSignIn.sharedInstance()?.signOut()
            accountManager.logOut()
        } else {
            GIDSignIn.sharedInstance()?.scopes.append("https://www.googleapis.com/auth/calendar")
            GIDSignIn.sharedInstance()?.signIn()
        }
    }
    private func setupAppearance() {
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .theme
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    // MARK: - GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let user = user {
            let userInfo = UserInfo(userId: user.userID,
                                    photoURL: user.profile.hasImage ? user.profile.imageURL(withDimension: 500) : nil,
                                    emailAddress: user.profile.email,
                                    firstName: user.profile.givenName,
                                    secondName: user.profile.familyName)
            accountManager.logIn(with: userInfo, code: user.serverAuthCode) { success in
                if !success {
                    GIDSignIn.sharedInstance()?.signOut()
                }
            }
        } else {
            accountManager.logOut()
        }
    }
}
