//
//  CreateWashroomButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct CreateWashroomButton: View {
    @ObservedObject var building: Building
    @State private var showCreateWashroom = false
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        // Use a popover on iPad, use a sheet on iPhone.
        // This is a workaround to address SwiftUI bugs with popovers on iPhone.
        HStack {
            if horizontalSizeClass == .compact {
                Button(action: { self.showCreateWashroom = true }, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Washroom")
                    }
                })
                    .sheet(isPresented: $showCreateWashroom, content: { CreateWashroomView(show: self.$showCreateWashroom, building: self.building) } )
            } else {
                Button(action: { self.showCreateWashroom = true }, label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Washroom")
                    }
                })
                    .popover(isPresented: $showCreateWashroom, content: { CreateWashroomView(show: self.$showCreateWashroom, building: self.building) } )
            }
        }
    }
}

struct CreateWashroomButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomButton(building: Building())
    }
}
