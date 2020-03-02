//
//  CreateReviewView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct CreateReviewView: View {
    @Binding var show: Bool
    @ObservedObject var reviews: Reviews
    @State private var cleanlinessRating = 0.0
    @State private var privacyRating = 0.0
    @State private var paperRating = 0.0
    @State private var smellRating = 0.0
    @State private var comment = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ratings")) {
                    EditableRatingView(rating: $cleanlinessRating, label: "✨ Cleanliness")
                    EditableRatingView(rating: $privacyRating, label: "🤚 Privacy")
                    EditableRatingView(rating: $paperRating, label: "🧻 Paper Quality")
                    EditableRatingView(rating: $smellRating, label: "👃 Smell")
                }
                TextField("Comment", text: $comment)
            }
            .navigationBarTitle("New Review", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(action: {
                    self.reviews.postReview(review:
                        Review(
                            id: 0,
                            washroomID: 0,
                            user: nil,
                            createdAt: Date(),
                            upvoteCount: 0,
                            ratings: Washroom.Ratings(
                                privacy: self.privacyRating,
                                toiletPaperQuality: self.paperRating,
                                smell: self.smellRating,
                                cleanliness: self.cleanlinessRating
                            ),
                            comment: self.comment
                        )
                    )
                    self.show = false
                }, label: { Text("Post") })
                    .disabled(cleanlinessRating <= 0 || privacyRating <= 0 || paperRating <= 0 || smellRating <= 0)
            )

        }
    }
}

struct CreateReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = [Washroom.Amenity]()
        let ratings = Washroom.Ratings(privacy: 4, toiletPaperQuality: 4, smell: 4, cleanliness: 4)
        let location = Location(latitude: 0, longitude: 0)
        let washroom = Washroom(id: 1, title: "Washroom", location: location, gender: .all, floor: 1, buildingID: 1, createdAt: Date(), reviewsCount: 0, overallRating: 4, averageRatings: ratings, amenities: amenities)
          
        return CreateReviewView(show: .constant(true), reviews: Reviews(for: washroom))
    }
}
