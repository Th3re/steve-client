//
//  SelectWindowView.swift
//  Steve
//
//  Created by Mateusz Stompór on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct SelectWindowView: View {
    // MARK: - Properties
    @Binding var showCreator: Bool
    @State var participants: [UserInfo]
    @State var date: Date
    @EnvironmentObject var selectWindowViewModel: SelectWindowViewModel
    // MARK: - View
    var body: some View {
        List(selectWindowViewModel.windows) { window in
            NavigationLink(destination: AdjustWindowView(showCreator: self.$showCreator,
                                                         window: window,
                                                         participants: self.participants)) {
            WindowRowView(window: window)
        }.isDetailLink(false)
        }.onAppear {
            self.selectWindowViewModel.fetch(forDate: self.date, participants: self.participants)
        }.navigationBarTitle("Select Window", displayMode: .inline)
    }
}
