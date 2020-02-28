//
//  AmenitiesSelectionView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct AmenitiesSelectionView: View {
    @Binding var amenities: [Washroom.Amenity]

    var body: some View {
        ForEach(Washroom.Amenity.allCases, id: \.self) { amenity in
            HStack {
                Text("\(amenity.rawValue)")
                Spacer()
                Text("\(amenity.emoji ?? "")")
                if self.amenities.contains(amenity) {
                    Image(systemName: "checkmark.circle.fill")
                } else {
                    Image(systemName: "circle")
                }
            }.onTapGesture {
                if self.amenities.contains(amenity) {
                    self.amenities.removeAll(where: { $0 == amenity})
                } else {
                    self.amenities.append(amenity)
                }
            }
        }

    }
}

struct AmenitiesSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesSelectionView(amenities: .constant([]))
    }
}
