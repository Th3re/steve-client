//
//  CurrentLocationViewModel.swift
//  Steve
//
//  Created by Mateusz Stompór on 25/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import Combine
import CoreLocation

class CurrentLocationViewModel: ObservableObject {
    // MARK: - Properties
    @Published var location: CLLocation?
    private var subscription: AnyCancellable?
    // MARK: - Initialization
    init(localizer: Localizer) {
        subscription = localizer
            .makeConnectable()
            .autoconnect()
            .map { Optional($0) }
            .assign(to: \.location, on: self)
    }
    // MARK: - Deinitialization
    deinit {
        subscription?.cancel()
    }
}
