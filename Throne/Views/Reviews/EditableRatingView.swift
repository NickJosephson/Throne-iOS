//
//  EditableRatingView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct EditableRatingView: View {
    @Binding var rating: Double
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

            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .onTapGesture {
                        self.rating = Double(number)
                    }
            }
                .accessibility(hidden: true)
        }
        .accessibilityElement(children: .combine)
        .accessibility(value: {
            if rating > 0.0 {
                return Text("\(rating, specifier: "%.1f") stars")
            } else {
                return Text("No Rating")
            }
        }())
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .decrement: self.rating = max(self.rating - 1, 1)
            case .increment: self.rating = min(self.rating + 1, Double(self.maximumRating))
            default: break
            }
        }
    }
}

struct EditableRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EditableRatingView(rating: .constant(2.5))
    }
}
