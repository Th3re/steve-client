//
//  AccountManager.swift
//  Steve
//
//  Created by Mateusz Stompór on 26/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class AccountManager: ObservableObject {
    // MARK: - Properties
    var loggedUser = CurrentValueSubject<UserInfo?, Never>(nil)
    var previousLoggedUser = CurrentValueSubject<UserInfo?, Never>(nil)
    private let serverAddress: String
    // MARK: - Initialization
    init(serverAddress: String) {
        self.serverAddress = serverAddress
    }
    // MARK: - Internal
    func logOut() {
        previousLoggedUser.send(loggedUser.value)
        loggedUser.send(nil)
    }
    func logInWith(userInfo: UserInfo, code: String, completion: @escaping (Bool)->()) {
        sendAuthorization(code: code) { success in
            DispatchQueue.main.async { [weak self] in
                if success, let self = `self` {
                    self.previousLoggedUser.send(self.loggedUser.value)
                    self.loggedUser.send(userInfo)
                }
                completion(success)
            }
        }
    }
    private func sendAuthorization(code: String, completion: @escaping (Bool)->()) {
        let url = URL(string: serverAddress + "/auth/auth?code=\(code)&scope=none")!
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("error:", error.localizedDescription)
                completion(false)
                return
            }
            guard let data = data else {
                completion(false)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                    completion(false)
                    return
                }
                print("json:", json)
                completion(true)
            } catch {
                print("error:", error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
}
