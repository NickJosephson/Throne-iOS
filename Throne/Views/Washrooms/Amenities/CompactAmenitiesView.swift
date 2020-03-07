//
//  CompactAmenitiesView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct CompactAmenitiesView: View {
    var amenities: [Amenity]
    
    var body: some View {
        Text(amenities
            .filter { $0.emoji != nil }
            .reduce("") { currentResult, amenity in
                return currentResult + "   \(amenity.emoji!)"
            }
        )
        .lineLimit(1)
        .font(.caption)
        .foregroundColor(.secondary)
        .accessibility(
            label: Text(amenities.reduce("") { currentResult, amenity in
                return currentResult + "\(amenity.description) "
            })
        )
    }
}

struct CompactAmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CompactAmenitiesView(amenities: Amenity.allCases)
    }
}
