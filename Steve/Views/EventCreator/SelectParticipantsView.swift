//
//  SelectParticipantsView.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI


struct SelectParticipantsView: View {
    // MARK: - Properties
    @EnvironmentObject var viewModel: SelectParticipantsViewModel
    @State private var selectedDate = Date()
    @Binding var showCreator: Bool
    // MARK: - View
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 25)
                Text("Participants").foregroundColor(.black).font(.system(size: 25, weight: .black, design: Font.Design.default))
                MultiselectView(items: $viewModel.connections) { contactEntry in
                    HStack {
                        Text(contactEntry.contact.emailAddress)
                        Spacer()
                        if contactEntry.isSelected {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                Text("Date").foregroundColor(.black).font(.system(size: 25, weight: .black, design: Font.Design.default))
                DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
                    Text("")
                }.background(Color.white)
                NavigationLink(destination: SelectWindowView(showCreator: $showCreator, participants: viewModel.connections.map( { $0.contact }), date: selectedDate)) {
                    Text("Propose")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.theme)
                        .cornerRadius(25).padding()
                }.isDetailLink(false)
            }
            Spacer()
        }.navigationBarTitle("Create Meeting", displayMode: .inline)
    }
}
