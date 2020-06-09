//
//  URLRequest.swift
//  Steve
//
//  Created by Mateusz Stompór on 09/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Foundation

extension URLRequest {
    static func post(url: URL, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        request.httpBody = body
        return request
    }
}
