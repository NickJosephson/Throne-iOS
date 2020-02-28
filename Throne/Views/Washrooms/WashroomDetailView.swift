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
    @State private var showCreateReview = false
    @State private var isFavorite = false

    var body: some View {
        List {
//            Text("Floor \(washroom.floor) \(washroom.gender.emoji) \(washroom.gender.description)")
            Section(header: Text("Ratings")) {
                HStack {
                    Text("✨ Cleanliness")
                    Spacer()
                    RatingView(rating: washroom.averageRatings.cleanliness)
                }
                HStack {
                    Text("🤚 Privacy")
                    Spacer()
                    RatingView(rating: washroom.averageRatings.privacy)
                }
                HStack {
                    Text("🧻 Paper Quality")
                    Spacer()
                    RatingView(rating: washroom.averageRatings.toiletPaperQuality)
                }
                HStack {
                    Text("👃 Smell")
                    Spacer()
                    RatingView(rating: washroom.averageRatings.smell)
                }
            }
            Section() {
                NavigationLink(destination: AmenitiesView(amenities: self.washroom.amenities)) {
                    Text("Amenities")
                    Spacer()
                    CompactAmenitiesView(amenities: self.washroom.amenities)
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
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(washroom.title)
        .navigationBarItems(trailing:
            HStack {
                Button(action: { self.isFavorite.toggle() }, label: {
                    HStack {
                        if self.isFavorite {
                            Image(systemName: "bookmark.fill")
                        } else {
                            Image(systemName: "bookmark")
                        }
                        Text("Favourite")
                    }
                })
                .padding(.trailing)
                Button(action: { self.showCreateReview = true }, label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Review")
                    }
                })
                .popover(isPresented: self.$showCreateReview, content: { CreateReviewView(show: self.$showCreateReview) } )
                
            }
            
        )
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
