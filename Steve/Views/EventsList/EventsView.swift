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
    @State var showCreator: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme
                List(viewModel.eventsList) { event in
                    EventsRow(event: event)
                }
                .navigationBarTitle("Events")
                .navigationBarItems(trailing:
                    NavigationLink(destination: SelectParticipantsView(showCreator: $showCreator), isActive: $showCreator) {
                        Image(systemName: "plus.circle.fill").font(.largeTitle)
                    }.isDetailLink(false)
                )
            }
        }
    }
}
