//
//  EventCreatorView.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct EventsView: View {
    @EnvironmentObject var viewModel: EventsListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme
                List(viewModel.eventsList) { event in
                    NavigationLink(destination: SelectParticipantsView()) {
                        EventsRow(event: event)
                    }
                }
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
