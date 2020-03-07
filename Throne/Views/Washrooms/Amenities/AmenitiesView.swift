//
//  AmenitiesView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-21.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct AmenitiesView: View {
    var amenities: [Amenity]

    var body: some View {
        List {
            if amenities.count == 0 {
                Text("No Amenities")
                .foregroundColor(.secondary)
            }
            
            ForEach(amenities, id: \.self) { amenity in
                HStack {
                    Text(amenity.description)
                    Spacer()
                    Text(amenity.emoji ?? "")
                        .accessibility(hidden: true)
                }
                    .accessibilityElement(children: .combine)
            }
        }
        .navigationBarTitle("Amenities", displayMode: .inline)
    }
}

struct AmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesView(amenities: Amenity.allCases)
    }
}
