//
//  Environment.swift
//  Steve
//
//  Created by Mateusz Stompór on 29/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

struct GoogleConfig: PropertyListDecodable {
    // MARK: - Aliases
    typealias T = GoogleConfig
    // MARK: - Properties
    let serverClientId: String
    let clientId: String
    // MARK: - PropertyListDecodable
    static func fromPropertyList(name: String) -> GoogleConfig? {
        guard let config = NSDictionary.fromPropertyList(name: name),
            let serverClientId = config["SERVER_CLIENT_ID"] as? String,
            let clientId = config["CLIENT_ID"] as? String else {
            return nil
        }
        return GoogleConfig(serverClientId: serverClientId, clientId: clientId)
    }
}

struct AppConfig: PropertyListDecodable {
    // MARK: - Aliases
    typealias T = AppConfig
    // MARK: - Properties
    let serverAddress: String
    // MARK: - PropertyListDecodable
    static func fromPropertyList(name: String) -> AppConfig? {
        guard let config = NSDictionary.fromPropertyList(name: name),
            let serverAddress = config["SERVER_ADDRESS"] as? String else {
            return nil
        }
        return AppConfig(serverAddress: serverAddress)
    }
}

struct Environment {
    let googleConfig: GoogleConfig
    let appConfig: AppConfig
}
