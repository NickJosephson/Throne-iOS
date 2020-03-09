//
//  AmenitiesSelectionView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct AmenitiesSelectionView: View {
    @Binding var amenities: [Amenity]

    var body: some View {
        ForEach(Amenity.allCases, id: \.self) { amenity in
            Button(action: {
                if self.amenities.contains(amenity) {
                    self.amenities.removeAll(where: { $0 == amenity})
                } else {
                    self.amenities.append(amenity)
                }
            }, label: {
                HStack {
                    Text("\(amenity.description)")
                    Spacer()
                    HStack {
                        Text("\(amenity.emoji ?? "")")
                        if self.amenities.contains(amenity) {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "circle")
                        }
                    }
                        .accessibility(hidden: true)
                }
            })
                .accessibility(addTraits: self.amenities.contains(amenity) ? .isSelected : [])
        }
    }
    
}

struct AmenitiesSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesSelectionView(amenities: .constant(Amenity.allCases))
    }
}
