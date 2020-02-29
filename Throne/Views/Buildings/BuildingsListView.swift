//
//  BuildingsListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct BuildingsListView: View {
    var buildings: [Building]
    
    var body: some View {
        ForEach(buildings, id: \.title) { building in
            NavigationLink(destination: BuildingDetailView(building: building)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(building.title)
                            .lineLimit(nil)
                            .layoutPriority(1)
                        .fixedSize(horizontal: false, vertical: true)

                        RatingView(rating: building.overallRating)
                            .padding(.bottom)
                    }
                    Spacer()
                    Text("\(building.distance, specifier:"%.1f")m")
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: true, vertical: true)
                }
            }
        }
    }
}

struct BuildingsListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingsListView(buildings: [])
    }
}
