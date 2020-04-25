//
//  AccountView.swift
//  Steve
//
//  Created by Mateusz Stompór on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            Color.theme
            Text("You must first sign in")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
