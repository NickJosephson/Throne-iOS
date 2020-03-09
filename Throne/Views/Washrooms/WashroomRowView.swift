//
//  WashroomRowView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomRowView: View {
    @ObservedObject var washroom: Washroom
    var showBuilding = true
    
    var body: some View {
        NavigationLink(destination: WashroomDetailView(washroom: washroom)) {
            HStack {
                VStack(alignment: .leading) {
                    if showBuilding {
                        Text(washroom.buildingTitle)
                            .lineLimit(nil)
                            .padding(.bottom, 5)
                        Text("\(washroom.gender.emoji) Floor \(washroom.floor) \(washroom.additionalTitle)")
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .accessibility(label: Text("\(washroom.gender.description) Floor \(washroom.floor) \(washroom.additionalTitle)"))
                    } else {
                        Text("\(washroom.gender.emoji) Floor \(washroom.floor) \(washroom.additionalTitle)")
                            .lineLimit(1)
                            .accessibility(label: Text("\(washroom.gender.description) Floor \(washroom.floor) \(washroom.additionalTitle)"))
                            .padding(.bottom, 5)
                    }
                    RatingView(rating: washroom.overallRating)
                        .padding(.bottom)
                }
                    .layoutPriority(1)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                VStack(alignment: .trailing) {
                    if washroom.distance != nil {
                        Text(washroom.distanceDescription)
                    }
                }
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: true, vertical: true)
            }
        }
    }
}

struct WashroomRowView_Previews: PreviewProvider {
    static var previews: some View {
        return WashroomRowView(washroom: Washroom())
    }
}
