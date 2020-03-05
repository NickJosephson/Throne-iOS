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
    @ObservedObject var washroom: Washroom
    
    @State private var ratings = Ratings()
    @State private var comment = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ratings")) {
                    HStack {
                        Text("✨").accessibility(hidden: true)
                        EditableRatingView(rating: $ratings.cleanliness, label: "Cleanliness")
                    }
                    HStack {
                        Text("🤚").accessibility(hidden: true)
                        EditableRatingView(rating: $ratings.privacy, label: "Privacy")
                    }
                    HStack {
                        Text("🧻").accessibility(hidden: true)
                        EditableRatingView(rating: $ratings.toiletPaperQuality, label: "Paper Quality")
                    }
                    HStack {
                        Text("👃").accessibility(hidden: true)
                        EditableRatingView(rating: $ratings.smell, label: "Smell")
                    }
                    
                }
                TextField("Comment", text: $comment)
            }
            .navigationBarTitle("New Review", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { self.show = false }, label: { Text("Cancel") }),
                trailing: Button(action: {
                    self.washroom.postReview(review:
                        Review(ratings: self.ratings, comment: self.comment)
                    )
                    self.show = false
                }, label: { Text("Post") })
                    .disabled(ratings.cleanliness <= 0 || ratings.privacy <= 0 || ratings.toiletPaperQuality <= 0 || ratings.smell <= 0 || comment.isEmpty)
            )

        }
    }
}

struct CreateReviewView_Previews: PreviewProvider {
    static var previews: some View {
        return CreateReviewView(show: .constant(true), washroom: Washroom())
    }
}
