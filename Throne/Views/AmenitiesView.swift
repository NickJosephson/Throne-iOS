//
//  AmenitiesView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-21.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct AmenitiesView: View {
    var washroom: Washroom

    var body: some View {
        List {
            ForEach(washroom.amenities, id: \.self) { amenity in
                HStack {
                    Text(amenity.rawValue)
                    Spacer()
                    Text(amenity.emoji ?? "")
                }
            }
        }
        .navigationBarTitle("Amenities", displayMode: .inline)
    }
}

struct AmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = [Washroom.Amenity]()
        let ratings = Washroom.Ratings(privacy: 4, toiletPaperQuality: 4, smell: 4, cleanliness: 4)
        let location = Location(latitude: 0, longitude: 0)
        let washroom = Washroom(id: 1, title: "Washroom", location: location, gender: .all, floor: 1, buildingID: 1, createdAt: Date(), reviewsCount: 0, overallRating: 4, averageRatings: ratings, amenities: amenities)
        
        return AmenitiesView(washroom: washroom)
    }
}
