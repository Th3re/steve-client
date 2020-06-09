//
//  AdjustWindowView.swift
//  Steve
//
//  Created by Mateusz Stompór on 06/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import MapKit
import SwiftUI

struct AdjustWindowView: View {
    // MARK: - Properties
    @Binding var showCreator: Bool
    @State var window: Window
    @State var eventDescription = ""
    @State var selectedPlace: Place?
    @EnvironmentObject var adjustWindowViewModel: AdjustWindowViewModel
    @State var requestSent = false
    private var buttonActive: Bool {
        get {
            return selectedPlace != nil && eventDescription != ""
        }
    }
    var participants: [UserInfo]
    // MARK: - View
    var body: some View {
        VStack {
            MapView(selectedPlace: $selectedPlace, places: adjustWindowViewModel.meetingPoints)
            Text("Describe your event")
            TextField("Put description here...", text: $eventDescription)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            Spacer()
            HStack {
                Text("Start").foregroundColor(.gray).padding(.leading, 15)
                Text(DateFormatter.with(dateFormat: "HH:mm").string(from: window.start))
                Spacer()
                Button(action: { self.window.start.addTimeInterval(60*15) }) {
                    Text("+").font(.system(size: 30))
                }
                Button(action: { self.window.start.addTimeInterval(-60*15) }) {
                    Text("-").font(.system(size: 30))
                }.padding(.trailing, 15)
            }
            HStack {
                Text("End").foregroundColor(.gray).padding(.leading, 15)
                Text(DateFormatter.with(dateFormat: "HH:mm").string(from: window.end))
                Spacer()
                Button(action: { self.window.end.addTimeInterval(60*15) }) {
                    Text("+").font(.system(size: 30))
                }
                Button(action: { self.window.end.addTimeInterval(-60*15) }) {
                    Text("-").font(.system(size: 30))
                }.padding(.trailing, 15)
            }
            Button(action:{
                self.adjustWindowViewModel.createMeeting(window: self.window,
                                                         participants: self.participants,
                                                         meetingPoint: self.selectedPlace!.address,
                                                         summary: self.eventDescription)
                self.requestSent = true
            }){
                Text("Create")
                .foregroundColor(.white)
                .padding()
                .background(buttonActive ? Color.theme : Color.gray)
                .cornerRadius(25).padding()
            }.disabled(!buttonActive)
        }.onAppear {
            self.adjustWindowViewModel.fetchMeetingPoints(window: self.window, participants: self.participants)
        }.navigationBarTitle("Adjust Window", displayMode: .inline)
        .alert(isPresented: $requestSent) {
            Alert(title: Text("Success!"), message: Text("Event has been added to the calendar"), dismissButton: .default(Text("Close")))
        }
    }
}
