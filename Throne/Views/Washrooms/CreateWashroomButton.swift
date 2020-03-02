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

    var body: some View {
        Button(action: { self.showCreateWashroom = true }, label: {
            HStack {
                Image(systemName: "plus")
                Text("Add Washroom")
            }
        })
            .popover(isPresented: $showCreateWashroom, content: { CreateWashroomView(show: self.$showCreateWashroom, building: self.building) } )
    }
}

struct CreateWashroomButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomButton(building: Building())
    }
}
