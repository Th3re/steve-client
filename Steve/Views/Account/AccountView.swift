//
//  AccountView.swift
//  Steve
//
//  Created by Mateusz Stompór on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel: AccountViewModel
    var body: some View {
        ZStack {
            Color.theme.edgesIgnoringSafeArea(.top)
            VStack {
                GeometryReader { metrics in
                    ZStack {
                        VStack(spacing: CGFloat(0)) {
                            Color.theme.frame(height: metrics.size.height * 0.3)
                            ZStack {
                                Color(UIColor.systemBackground).frame(height: metrics.size.height * 0.7)
                                VStack {
                                    Spacer()
                                    LoginPresenter(accountManager: self.viewModel.accountManager, loggedUser: self.viewModel.loggedUser)
                                    .frame(width: 200, height: 50, alignment: .center)
                                    .offset(x: 0, y: -20)
                                }
                            }
                        }
                        UserDetailsView()
                            .frame(width: metrics.size.width * 0.6, height: metrics.size.width * 0.6)
                            .offset(x: 0, y: -metrics.size.height * 0.15)
                    }
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
