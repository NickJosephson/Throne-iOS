//
//  NearMeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeView: View {
    @ObservedObject var settings = PersistentSettings()

    var body: some View {
        NavigationView {
            RoomsListView()
            .navigationBarTitle(Text("Near Me"))
            Text("No \(settings.preferredTerm.capitalized) Selected")
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct RoomsListView: View {
    @ObservedObject var model = NearMeListModel()
    
    var body: some View {
        List {
            ForEach(model.washrooms, id: \.title) { washroom in
                NavigationLink(destination: WashroomDetailView(washroom: washroom)) {
                    VStack(alignment: .leading) {
                        Text(washroom.title)
                        HStack {
                            ForEach(washroom.amenities, id: \.self) { amenity in
                                Text(amenity).font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }
                    .layoutPriority(1)
                    Spacer()
                    Text("\(washroom.overallRating, specifier:"%.1f")").font(.largeTitle)
                    .layoutPriority(2)
                }
            }
        }
    }
}

struct NearMeView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeView()
    }
}


struct Room {
    var title: String
    var amenities: [String]
    var rating: String
}

var rooms = [
    Room(title: "Tache Hall", amenities: ["🚽","🧻","🧴"], rating: "🤩"),
    Room(title: "6th Floor E2", amenities: ["🚽","🧻","🧴"], rating: "💩"),
    Room(title: "Aaron's House", amenities: ["🚽","🛀","🚻"], rating: "👍"),
    Room(title: "151 Research", amenities: ["🚽","🧻","🧴"], rating: "💤"),
    Room(title: "University Center", amenities: ["🚽","🧻","🧴"], rating: "🤮")
]

