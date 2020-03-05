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

    var body: some View {
        NavigationLink(destination: WashroomDetailView(washroom: washroom)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(washroom.title)
                        .lineLimit(nil)
                        .layoutPriority(1)
                    .fixedSize(horizontal: false, vertical: true)

                    RatingView(rating: washroom.overallRating)
                        .padding(.bottom)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    if washroom.distance != nil {
                        Text(washroom.distanceDescription)
                    }
                    Text("Floor \(washroom.floor)")
                    Text(washroom.gender.description)
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
