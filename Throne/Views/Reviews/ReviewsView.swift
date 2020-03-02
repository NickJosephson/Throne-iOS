//
//  ReviewsView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-21.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ReviewsView: View {
    @ObservedObject private var model: Reviews
    @State private var showCreateReview = false
    
    init(washroom: Washroom) {
        self.model = Reviews(for: washroom)
    }
    
    var body: some View {
        List {
            ForEach(model.reviews, id: \.id) { review in
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.circle")
                            Text("\(review.user.username)")
                            Spacer()
                            Text("\(review.getRelativeDateDescription())")
                        }
                        .font(.headline)
                        .foregroundColor(.secondary)
                        HStack(alignment: .top) {
                            Text(review.comment ?? "")
                            Spacer()
                            VStack{
                                Text("✨ \(review.ratings.cleanliness, specifier:"%.0f")")
                                Text("🤚 \(review.ratings.privacy, specifier:"%.0f")")
                                Text("🧻 \(review.ratings.toiletPaperQuality, specifier:"%.0f")")
                                Text("👃 \(review.ratings.smell, specifier:"%.0f")")
                            }.layoutPriority(1)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Reviews", displayMode: .inline)
        .navigationBarItems(trailing: ReviewButton(reviews: self.model))
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = [Washroom.Amenity]()
        let ratings = Washroom.Ratings(privacy: 4, toiletPaperQuality: 4, smell: 4, cleanliness: 4)
        let location = Location(latitude: 0, longitude: 0)
        let washroom = Washroom(id: 1, title: "Washroom", location: location, gender: .all, floor: 1, buildingID: 1, createdAt: Date(), reviewsCount: 0, overallRating: 4, averageRatings: ratings, amenities: amenities)

        return ReviewsView(washroom: washroom)
    }
}
