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
                leading: Button(action: {self.show = false}, label: { Text("Cancel") }),
                trailing: Button(action: {self.show = false}, label: { Text("Post") })
                    .disabled(cleanlinessRating <= 0 || privacyRating <= 0 || paperRating <= 0 || smellRating <= 0)
            )

        }
    }
}

struct CreateReviewView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReviewView(show: .constant(true))
    }
}
