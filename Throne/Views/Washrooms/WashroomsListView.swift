//
//  WashroomsListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomsListView: View {
    var washrooms: [Washroom]
    
    var body: some View {
        ForEach(washrooms, id: \.title) { washroom in
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
                        Text("\(washroom.distance, specifier:"%.1f")m")
                        Text("Floor \(washroom.floor)")
                        Text("\(washroom.gender.description)")
                    }
                        .multilineTextAlignment(.trailing)                    
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: true, vertical: true)
                }
            }
        }
    }
}

struct WashroomsListView_Previews: PreviewProvider {
    static var previews: some View {
        WashroomsListView(washrooms: [])
    }
}
