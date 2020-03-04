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
    static var shared = NearMe() // Shared instance to use across application

    var requestDataUpdate = PassthroughSubject<Void, Never>()
    private var washroomsSubscription: AnyCancellable!
    private var buildingsSubscription: AnyCancellable!
    
    @Published var washrooms: [Washroom] = []
    @Published var buildings: [Building] = []
    
    init() {
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        // create publisher for indicating when to perform near me update
        let loginUpdatePublisher = LoginManager.shared.loginCompleted
        let refreshUpdatePublisher = LoginManager.shared.refreshCompleted
        let locationUpdatePublisher = LocationManager.shared.$currentLocation
            .filter { $0 != nil }
            .map { _ in return }
        let timerUpdatePublisher = Timer.publish(every: TimeInterval(exactly: 300.0)!, on: RunLoop.current, in: .default)
            .autoconnect()
            .map { _ in return }
        let shouldUpdatePublisher = timerUpdatePublisher
            .merge(with: locationUpdatePublisher)
            .throttle(for: .seconds(30), scheduler: RunLoop.current, latest: false)
            .merge(with: refreshUpdatePublisher, loginUpdatePublisher)
            .merge(with: requestDataUpdate)
            .throttle(for: .seconds(5), scheduler: RunLoop.current, latest: false)
            .eraseToAnyPublisher()
        
        washroomsSubscription = shouldUpdatePublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchWashrooms(near: LocationManager.shared.currentLocation) { washrooms in
                        promise(.success(washrooms))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.washrooms, on: self)

        buildingsSubscription = shouldUpdatePublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchBuildings(near: LocationManager.shared.currentLocation) { buildings in
                        promise(.success(buildings))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.buildings, on: self)
    }

}
