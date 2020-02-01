//
//  NearMeListModel.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-01.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation

final class NearMeListModel: ObservableObject {    
    init() {
        fetchWashrooms()
    }
    
    @Published var washrooms = [Washroom]()
    
    private func fetchWashrooms() {
        getAllWashrooms() { allWashrooms in
            DispatchQueue.main.async {
                self.washrooms = allWashrooms
            }
        }
    }
}
