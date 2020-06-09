//
//  WindowRowView.swift
//  Steve
//
//  Created by Mateusz Stompór on 09/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct WindowRowView: View {
    // MARK: - Properties
    var window: Window
    // MARK: - View
    var body: some View {
        VStack {
            Text(DateFormatter.with(dateFormat: "yyyy-MM-dd").string(from: window.start))
            HStack {
                Text("Start").foregroundColor(.gray)
                Spacer()
                Text(DateFormatter.with(dateFormat: "HH:mm").string(from: window.start)).fontWeight(.heavy)
            }
            HStack {
                Text("End").foregroundColor(.gray)
                Spacer()
                Text(DateFormatter.with(dateFormat: "HH:mm").string(from: window.end)).fontWeight(.heavy)
            }
        }
    }
}
