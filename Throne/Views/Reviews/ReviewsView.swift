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
            if washroom.reviews.count == 0 {
                Text("No Reviews")
                    .foregroundColor(.secondary)
            }
            
            ForEach(washroom.reviews.sorted { $0.createdAt > $1.createdAt }, id: \.id) { review in
                ReviewRowView(review: review)
                    .accessibilityElement(children: .combine)
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
