//
//  NearMeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeView: View {
    var body: some View {
        NavigationView {
            RoomsListView()
            .navigationBarTitle(Text("Near Me"))
            Text("No Washroom Selected")
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct RoomsListView: View {
    var body: some View {
        List {
            ForEach(rooms, id: \.title) { room in
                NavigationLink(destination: WashroomDetailView(room: room)) {
                    VStack(alignment: .leading) {
                        Text(room.title)
                        HStack {
                            ForEach(room.amenities, id: \.self) { amenity in
                                Text(amenity).font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }
                    .layoutPriority(1)
                    Spacer()
                    Text(room.rating).font(.largeTitle)
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

