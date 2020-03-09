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

    var body: some View {
        Button(action: { self.showCreateReview = true }, label: {
            HStack() {
                Image(systemName: "square.and.pencil")
                Text("Review")
            }
        })
            .popover(isPresented: self.$showCreateReview, content: {
                CreateReviewView(show: self.$showCreateReview, washroom: self.washroom)
            })
    }
    
}

struct ReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        ReviewButton(washroom: Washroom())
    }
}
