//
//  WashroomsListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomsListView: View {
    var washrooms: [Washroom]
    
    var body: some View {
        ForEach(washrooms, id: \.title) { washroom in
            NavigationLink(destination: WashroomDetailView(washroom: washroom)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(washroom.title)
                            .lineLimit(nil)
                            .layoutPriority(1)
                        .fixedSize(horizontal: false, vertical: true)

                        RatingView(rating: washroom.overallRating)
                            .padding(.bottom)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(washroom.distance, specifier:"%.1f")m")
                        Text("Floor \(washroom.floor)")
                        Text("\(washroom.gender.description)")
                    }
                        .multilineTextAlignment(.trailing)                    
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: true, vertical: true)
                }
            }
        }
    }
}

struct WashroomsListView_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = [Washroom.Amenity]()
        let ratings = Washroom.Ratings(privacy: 4, toiletPaperQuality: 4, smell: 4, cleanliness: 4)
        let location = Location(latitude: 0, longitude: 0)
        let washroom = Washroom(id: 1, title: "Washroom", location: location, gender: .all, floor: 1, buildingID: 1, createdAt: Date(), reviewsCount: 0, overallRating: 4, averageRatings: ratings, amenities: amenities)
        
        return WashroomsListView(washrooms: [washroom])
    }
}
