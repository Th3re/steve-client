//
//  MainView.swift
//  Steve
//
//  Created by Mateusz Stompór on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.theme.edgesIgnoringSafeArea(.all)
            TabView {
                CurrentLocationView().tabItem {
                    Image(systemName: "location")
                    Text("Current Location")
                }
                AccountView().tabItem {
                    Image(systemName: "cloud")
                    Text("Account")
                }
                EventsView().tabItem {
                    Image(systemName: "calendar")
                    Text("Events")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
