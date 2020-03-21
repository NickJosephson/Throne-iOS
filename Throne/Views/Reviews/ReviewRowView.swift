//
//  ReviewRowView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-07.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ReviewRowView: View {
    var review: Review
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle").accessibility(hidden: true)
                    Text("\(review.user?.username ?? "")")
                    Spacer()
                    Text("\(review.relativeDateDescription)")
                }
                    .font(.headline)
                    .foregroundColor(.secondary)
                HStack(alignment: .top) {
                    Text(review.comment ?? "")
                    Spacer()
                    VStack{
                        Text("✨ \(review.ratings.cleanliness, specifier:"%.0f")")
                            .accessibility(label: Text("Cleanliness \(review.ratings.cleanliness, specifier:"%.0f")"))
                        Text("🤚 \(review.ratings.privacy, specifier:"%.0f")")
                            .accessibility(label: Text("Privacy \(review.ratings.privacy, specifier:"%.0f")"))
                        Text("🧻 \(review.ratings.toiletPaperQuality, specifier:"%.0f")")
                            .accessibility(label: Text("Paper Quality \(review.ratings.toiletPaperQuality, specifier:"%.0f")"))
                        Text("👃 \(review.ratings.smell, specifier:"%.0f")")
                            .accessibility(label: Text("Smell \(review.ratings.smell, specifier:"%.0f")"))
                    }.layoutPriority(1)
                }
            }
        }
            .accessibilityElement(children: .combine)
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView(review: Review())
    }
}
