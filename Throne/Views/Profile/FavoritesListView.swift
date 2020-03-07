//
//  FavoritesListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-07.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct FavoritesListView: View {
    @ObservedObject var nearMe: NearMe
    @ObservedObject var settings = PersistentSettings.shared
    @State var currentListType: FavoritesListType = FavoritesListType.favorites
    
    enum FavoritesListType {
        case favorites
    }
    
    var body: some View {
        List {
            Picker(selection: $currentListType, label: Text("List Type")) {
                Text("Favorites").tag(FavoritesListType.favorites)
            }
            .pickerStyle(SegmentedPickerStyle())
                        
            if currentListType == FavoritesListType.favorites {
                if nearMe.favorites.count == 0 {
                    Text("No \(settings.preferredTerm.capitalized) Favourited")
                    .foregroundColor(.secondary)
                }
                
                ForEach(nearMe.favorites, id: \.id) { washroom in
                    WashroomRowView(washroom: washroom)
                }
                .onDelete { offsets in
                    for offset in offsets {
                        self.nearMe.favorites[offset].toggleIsFavorite()
                    }
                }
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView(nearMe: NearMe.shared)
    }
}
