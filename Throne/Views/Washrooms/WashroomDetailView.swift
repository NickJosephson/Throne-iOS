//
//  WashroomDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomDetailView: View {
    @ObservedObject var washroom: Washroom

    var body: some View {
        List {
            Section(header: Text("Details")) {
                HStack {
                    Text("\(washroom.gender.description) Floor \(washroom.floor)")
                    Spacer()
                    Text("\(washroom.gender.emoji)").accessibility(hidden: true)
                }
                    .font(.title)
                NavigationLink(destination: AmenitiesView(amenities: self.washroom.amenities)) {
                    Text("Amenities")
                    Spacer()
                    CompactAmenitiesView(amenities: self.washroom.amenities)
                }
                .disabled(washroom.amenities.count == 0)
                .opacity(washroom.amenities.count == 0 ? 0.5 : 1.0)
            }
            Section(header: Text("Ratings")) {
                HStack {
                    Text("✨").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.cleanliness, label: "Cleanliness")
                }
                HStack {
                    Text("🤚").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.privacy, label: "Privacy")
                }
                HStack {
                    Text("🧻").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.toiletPaperQuality, label: "Paper Quality")
                }
                HStack {
                    Text("👃").accessibility(hidden: true)
                    RatingView(rating: washroom.averageRatings.smell, label: "Smell")
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
                NavigationLink(destination: MapDetailView(startLocation: washroom.location)) {
                    MapPreviewView(startLocation: washroom.location)
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                        .cornerRadius(10)
                }.accessibility(label: Text("Location on map"))
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(washroom.buildingTitle)
        .navigationBarItems(trailing:
            HStack(spacing: 20) {
                FavoriteButton(washroom: self.washroom)
                ReviewButton(washroom: self.washroom)
            }
        )
    }
}

struct WashroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return WashroomDetailView(washroom: Washroom())
    }
}
