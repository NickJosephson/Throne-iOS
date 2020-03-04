//
//  ReviewButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ReviewButton: View {
    @ObservedObject var washroom: Washroom
    @State private var showCreateReview = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        // Use a popover on iPad, use a sheet on iPhone.
        // This is a workaround to address SwiftUI bugs with popovers on iPhone.
        HStack(spacing: 0) {
            if horizontalSizeClass == .compact {
                Button(action: { self.showCreateReview = true }, label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Review")
                    }
                })
                    .sheet(isPresented: self.$showCreateReview, content: {
                        CreateReviewView(show: self.$showCreateReview, washroom: self.washroom)
                    })
            } else {
                Button(action: { self.showCreateReview = true }, label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Review")
                    }
                })
                    .popover(isPresented: self.$showCreateReview, content: {
                        CreateReviewView(show: self.$showCreateReview, washroom: self.washroom)
                    })
            }
        }
    }

}

struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewButton(washroom: Washroom())
    }
}
