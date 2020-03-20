//
//  FilterButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-08.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct FilterButton: View {
    @ObservedObject private var nearMe = NearMe.shared
    @State private var showFilterView = false

    var body: some View {
        Button(
            action: { self.showFilterView = true },
            label: {
                HStack {
                    if self.nearMe.filter == Filter() {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    } else {
                        Image(systemName: "line.horizontal.3.decrease.circle.fill")
                    }
                    Text("Filter")
                }
            }
        )
        .popover(
            isPresented: $showFilterView,
            content: { FilterView(show: self.$showFilterView) }
        )
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton()
    }
}
