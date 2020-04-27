//
//  UserDetailsView.swift
//  Steve
//
//  Created by Mateusz Stompór on 26/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var viewModel: UserDetailsViewModel
    var body: some View {
        VStack {
            ZStack {
                Color.white.mask(Circle())
                if viewModel.imageURL != nil {
                    RemoteImage(url: viewModel.imageURL!).mask(Circle())
                } else {
                    RemoteImage()
                }
            }
            .padding()
            .shadow(radius: 10)
            Text(viewModel.name).font(.system(size: 20)).fontWeight(.bold)
            Text(viewModel.email)
        }
    }
}
