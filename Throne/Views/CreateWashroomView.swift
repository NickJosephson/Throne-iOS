//
//  CreateWashroomView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct CreateWashroomView: View {
    @Binding var show: Bool

    var body: some View {
        NavigationView {
            Form {
                Text("")
            }
            .navigationBarItems(leading: Button(action: {self.show = false}, label: { Text("Cancel") }))
        }
    }
}


struct CreateWashroomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWashroomView(show: .constant(true))
    }
}
