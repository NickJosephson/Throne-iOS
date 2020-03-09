//
//  FilterButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-08.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct FilterButton: View {
    @ObservedObject var nearMe: NearMe
    @State private var showFilterView = false

    var body: some View {
        Button(action: { self.showFilterView = true }, label: {
            HStack {
                if nearMe.filterAmenities.isEmpty {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                } else {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                }
                Text("Filter")
            }
        })
            .popover(isPresented: $showFilterView, content: { FilterView(show: self.$showFilterView, nearMe: self.nearMe) } )
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(nearMe: NearMe.shared)
    }
}
