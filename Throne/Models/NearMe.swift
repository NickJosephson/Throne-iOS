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
    var requestFavoritesUpdate = PassthroughSubject<Void, Never>()
    var requestReviewsUpdate = PassthroughSubject<Void, Never>()
    private var washroomsSubscription: AnyCancellable!
    private var buildingsSubscription: AnyCancellable!
    private var favoritesSubscription: AnyCancellable!
    private var reviewsSubscription: AnyCancellable!

    @Published var washrooms: [Washroom] = []
    @Published var buildings: [Building] = []
    @Published var favorites: [Washroom] = []
    @Published var reviews: [Review] = []

    @Published var filterAmenities: [Amenity] = [] {
        didSet {
            self.requestDataUpdate.send()
        }
    }
    
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
                    ThroneEndpoint.fetchWashrooms(near: LocationManager.shared.currentLocation, filteredBy: self.filterAmenities) { washrooms in
                        promise(.success(washrooms))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.washrooms, on: self)

        buildingsSubscription = shouldUpdatePublisher
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchBuildings(near: LocationManager.shared.currentLocation, filteredBy: self.filterAmenities) { buildings in
                        promise(.success(buildings))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.buildings, on: self)
        
        favoritesSubscription = shouldUpdatePublisher
            .merge(with: requestFavoritesUpdate)
            .throttle(for: .seconds(1), scheduler: RunLoop.current, latest: false)
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchFavorites { favoriteWashrooms in
                        promise(.success(favoriteWashrooms))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.favorites, on: self)
        
        reviewsSubscription = shouldUpdatePublisher
            .merge(with: requestReviewsUpdate)
            .throttle(for: .seconds(1), scheduler: RunLoop.current, latest: false)
            .flatMap { _ in
                return Future { promise in
                    ThroneEndpoint.fetchReviews { reviews in
                        promise(.success(reviews))
                    }
                }
            }
            .receive(on: RunLoop.main)
            .assign(to: \.reviews, on: self)
    }

}
