//
//  BuildingRowView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct BuildingRowView: View {
    @ObservedObject var building: Building
    
    var body: some View {
        NavigationLink(destination: BuildingDetailView(building: building)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(building.title)
                        .lineLimit(nil)
                    RatingView(rating: building.overallRating)
                        .padding(.bottom)
                }
                    .layoutPriority(1)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text(building.distanceDescription)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: true, vertical: true)
            }
        }
    }
}

struct BuildingRowView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingRowView(building: Building())
    }
}
