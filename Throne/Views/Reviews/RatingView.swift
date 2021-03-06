//
//  RatingView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    var rating: Double
    var label = ""
    var maximumRating = 5
    
    func image(for number: Int) -> Image {
        if Double(number) <= rating {
            return Image(systemName: "star.fill")
        } else if Double(number) - 0.5 <= rating {
            return Image(systemName: "star.lefthalf.fill")
        } else {
            return Image(systemName: "star")
        }
    }

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
                Spacer()
            }
            
            HStack {
                ForEach(1..<maximumRating + 1) { number in
                        self.image(for: number)
                }
            }
            .accessibility(hidden: true)
            .foregroundColor(rating <= 0 ? Color.secondary : Color.primary)
        }
        .accessibilityElement(children: .combine)
        .accessibility(value: {
            if rating > 0.0 {
                return Text("\(rating, specifier: "%.1f") stars")
            } else {
                return Text("No Rating")
            }
        }())
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 2.5)
    }
}
