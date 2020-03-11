//
//  ProfileListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-07.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ProfileListView: View {
    @ObservedObject var nearMe: NearMe
    @ObservedObject var settings = PersistentSettings.shared
    @Binding var currentListType: ProfileListType
    
    enum ProfileListType {
        case favorites
        case reviews
    }
    
    var body: some View {
        List {
            Picker(selection: $currentListType, label: Text("List Type")) {
                Text("My Favorites").tag(ProfileListType.favorites)
                Text("My Reviews").tag(ProfileListType.reviews)
            }
            .pickerStyle(SegmentedPickerStyle())
                        
            if currentListType == ProfileListType.favorites {
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
            } else if currentListType == ProfileListType.reviews {
                if nearMe.reviews.count == 0 {
                    Text("No Reviews")
                    .foregroundColor(.secondary)
                }
                
                ForEach(nearMe.reviews.sorted { $0.createdAt > $1.createdAt }, id: \.self) { review in
                    NavigationLink(destination: WashroomDetailView(id: review.washroomID)) {
                        ReviewRowView(review: review)
                    }
                }
            }
        }
    }
}

struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView(nearMe: NearMe.shared, currentListType: .constant(.favorites))
    }
}
