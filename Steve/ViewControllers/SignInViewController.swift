//
//  SignInViewController.swift
//  Steve
//
//  Created by Piotr Persona on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import UIKit
import SwiftUI
import GoogleSignIn

struct SignInViewControllerPresentator: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SignInViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SignInViewControllerPresentator>) -> SignInViewController {
        return SignInViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignInViewController, context: UIViewControllerRepresentableContext<SignInViewControllerPresentator>) {
        
    }
}

class SignInViewController: UIViewController, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print(user)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().clientID = "1038421751376-7154253padv6ch3kmcoqrbbslog33abe.apps.googleusercontent.com"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GIDSignIn.sharedInstance()?.signIn()
    }
}
