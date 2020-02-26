//
//  WashroomDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomDetailView: View {
    var washroom: Washroom
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                HStack {
                    Text("✨ Cleanliness")
                    Spacer()
                    Text("\(washroom.averageRatings.cleanliness, specifier:"%.1f")").foregroundColor(.secondary)
                }
                HStack {
                    Text("🤚 Privacy")
                    Spacer()
                    Text("\(washroom.averageRatings.privacy, specifier:"%.1f")").foregroundColor(.secondary)
                }
                HStack {
                    Text("🧻 Paper Quality")
                    Spacer()
                    Text("\(washroom.averageRatings.toiletPaperQuality, specifier:"%.1f")").foregroundColor(.secondary)
                }
                HStack {
                    Text("👃 Smell")
                    Spacer()
                    Text("\(washroom.averageRatings.smell, specifier:"%.1f")").foregroundColor(.secondary)
                }
            }
            Section() {
                NavigationLink(destination: AmenitiesView(washroom: washroom)) {
                    Text("Amenities")
                    Spacer()
                    ForEach(washroom.amenities.filter { $0.emoji != nil }, id: \.self) { amenity in
                        Text(amenity.emoji!)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                NavigationLink(destination: ReviewsView(washroom: washroom)) {
                    Text("Reviews")
                    Spacer()
                    if washroom.reviewsCount != nil {
                        Text("\(washroom.reviewsCount!)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                }
            }
            Section(header: Text("Location")) {
                NavigationLink(destination: MapView().edgesIgnoringSafeArea(.vertical).navigationBarTitle("Location", displayMode: .inline)) {
                    MapView()
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                        .cornerRadius(10)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(washroom.title)
        .navigationBarItems(trailing: Text("\(washroom.overallRating, specifier:"%.1f")").font(.largeTitle) )
    }
}

struct WashroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = [Washroom.Amenity]()
        let ratings = Washroom.Ratings(privacy: 4, toiletPaperQuality: 4, smell: 4, cleanliness: 4)
        let location = Location(latitude: 0, longitude: 0)
        let washroom = Washroom(id: 1, title: "Washroom", location: location, gender: .all, floor: 1, buildingID: 1, createdAt: Date(), reviewsCount: 0, overallRating: 4, averageRatings: ratings, amenities: amenities)
        
        return WashroomDetailView(washroom: washroom)
    }
}
