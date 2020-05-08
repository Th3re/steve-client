//
//  EventCreatorView.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct EventsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme
                Text("Place implementation of event list here").foregroundColor(.white)
                .navigationBarTitle("Events")
                .navigationBarItems(trailing:
                    NavigationLink(destination: SelectParticipantsView()) {
                        Image(systemName: "plus.circle.fill").font(.largeTitle)
                    }
                )
            }
            
        }
    }
}
