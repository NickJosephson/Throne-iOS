//
//  ReviewButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ReviewButton: View {
    @ObservedObject var reviews: Reviews
    @State private var showCreateReview = false
    
    var body: some View {
        Button(action: { self.showCreateReview = true }, label: {
            HStack {
                Image(systemName: "square.and.pencil")
                Text("Review")
            }
        })
            .popover(isPresented: self.$showCreateReview, content: {
                CreateReviewView(show: self.$showCreateReview, reviews: self.reviews)
            })
    }

}

struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        let amenities = [Washroom.Amenity]()
        let ratings = Washroom.Ratings(privacy: 4, toiletPaperQuality: 4, smell: 4, cleanliness: 4)
        let location = Location(latitude: 0, longitude: 0)
        let washroom = Washroom(id: 1, title: "Washroom", location: location, gender: .all, floor: 1, buildingID: 1, createdAt: Date(), reviewsCount: 0, overallRating: 4, averageRatings: ratings, amenities: amenities)
        
        return ReviewButton(reviews: Reviews(for: washroom))
    }
}
