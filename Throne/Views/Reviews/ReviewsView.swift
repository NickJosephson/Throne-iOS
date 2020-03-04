//
//  ReviewsView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-21.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ReviewsView: View {
    @ObservedObject var washroom: Washroom
    @State private var showCreateReview = false
    
    init(washroom: Washroom) {
        self.washroom = washroom
        washroom.setupReviewsSubscription()
    }
    
    var body: some View {
        List {
            ForEach(washroom.reviews.sorted { $0.createdAt > $1.createdAt }, id: \.id) { review in
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
        .navigationBarItems(trailing: ReviewButton(washroom: self.washroom))
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(washroom: Washroom())
    }
}
