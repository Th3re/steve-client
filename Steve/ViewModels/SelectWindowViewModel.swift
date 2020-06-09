//
//  SelectWindowViewModel.swift
//  Steve
//
//  Created by Mateusz Stompór on 07/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import Foundation

class SelectWindowViewModel: ObservableObject {
    // MARK: - Properties
    @Published var windows = [Window]()
    private let factory: ProposeMeetingDateNetTaskFactory
    private var subscription: AnyCancellable?
    // MARK: - Initialization
    init(factory: ProposeMeetingDateNetTaskFactory) {
        self.factory = factory
    }
    func fetch(forDate date: Date, participants: [UserInfo]) {
        let ids = participants.map { $0.userId }
        subscription = factory.build(with: .init(date: date, participantsIds: ids))
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { value in
                self.windows = value
            })
    }
    // MARK: - Deinitialization
    deinit {
        subscription?.cancel()
    }
}
