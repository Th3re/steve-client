//
//  AdjustWindowViewModel.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import MapKit
import Combine

class AdjustWindowViewModel: ObservableObject {
    // MARK: - Properties
    @Published var meetingPoints = [Place]()
    @Published var meetingCreated = false
    private let meetingPointFactory: MeetingPointNetTaskFactory
    private let createMeetingFactory: CreateMeetingNetTaskFactory
    private let accountManager: AccountManageable
    private var meetingPointSubscription: AnyCancellable?
    private var createMeetingSubscription: AnyCancellable?
    // MARK: - Initialization
    init(meetingPointFactory: MeetingPointNetTaskFactory,
         createMeetingFactory: CreateMeetingNetTaskFactory,
         accountManager: AccountManageable) {
        self.meetingPointFactory = meetingPointFactory
        self.createMeetingFactory = createMeetingFactory
        self.accountManager = accountManager
    }
    // MARK: - Internal
    func createMeeting(window: Window, participants: [UserInfo], meetingPoint: String, summary: String) {
        guard let host = accountManager.signedUser else {
            print("There is no host")
            return
        }
        let ids = participants.map { $0.emailAddress }
        createMeetingSubscription = createMeetingFactory.build(with: CreateMeetingNetTaskConfig(window: window,
                                                                                                host: host.userId,
                                                                                                participantIds: ids.filter { $0 != host.emailAddress },     summary: summary,
                                                                                                meetingPoint: meetingPoint))
        .publisher
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in print("Completion recived while fetching meeting points") },
              receiveValue: { meetingCreated in
                self.meetingCreated = meetingCreated
        })
    }
    func fetchMeetingPoints(window: Window, participants: [UserInfo]) {
        guard let host = accountManager.signedUser?.userId else {
            print("There is no host")
            return
        }
        let ids = participants.map { $0.userId }
        meetingPointSubscription = meetingPointFactory.build(with: MeetingPointNetTaskConfig(window: window,
                                                                                             host: host,
                                                                                             participantIds: ids.filter { $0 != host }))
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in print("Completion recived while fetching meeting points") },
                  receiveValue: { meetingPoints in
                    self.meetingPoints = meetingPoints
            })
    }
}
