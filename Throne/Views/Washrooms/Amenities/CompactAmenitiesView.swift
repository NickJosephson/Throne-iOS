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
        ForEach(amenities.filter { $0.emoji != nil }, id: \.self) { amenity in
            Text(amenity.emoji!)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct CompactAmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CompactAmenitiesView(amenities: Amenity.allCases)
    }
}
