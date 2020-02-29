//
//  NearMe.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import Combine

final class NearMe: ObservableObject {
    private var shouldUpdatePublisher: AnyPublisher<Void, Never>
    private var washroomsSubscription: AnyCancellable!
    private var buildingsSubscription: AnyCancellable!

    @Published var washrooms: [Washroom] = []
    @Published var buildings: [Building] = []
    
    init() {
        // create publisher for indicating when to perform near me update
        let loginUpdatePublisher = LoginManager.shared.$isLoggedIn
            .filter { $0 }
            .map { _ in return }
        let refreshUpdatePublisher = LoginManager.shared.refreshCompleted
        let locationUpdatePublisher = LocationManager.shared.$currentLocation
            .filter { $0 != nil }
            .map { _ in return }
        let timerUpdatePublisher = Timer.publish(every: TimeInterval(exactly: 300.0)!, on: RunLoop.current, in: .default)
            .autoconnect()
            .map { _ in return }
        shouldUpdatePublisher = timerUpdatePublisher
            .merge(with: refreshUpdatePublisher, locationUpdatePublisher, loginUpdatePublisher)
            .throttle(for: .seconds(10), scheduler: RunLoop.current, latest: false)
            .eraseToAnyPublisher()
        
        washroomsSubscription = shouldUpdatePublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchWashrooms(near: LocationManager.shared.currentLocation) { washrooms in
                        promise(.success(washrooms))
                    }
                }
            }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.washrooms, on: self)

        buildingsSubscription = shouldUpdatePublisher
            .flatMap {_ in
                return Future { promise in
                    ThroneEndpoint.fetchBuildings(near: LocationManager.shared.currentLocation) { buildings in
                        promise(.success(buildings))
                    }
                }
            }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.buildings, on: self)
    }
    
}
