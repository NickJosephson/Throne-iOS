//
//  ShareButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-24.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct ShareButton: View {
    @ObservedObject var washroom: Washroom
    @State private var showShareSheet = false

    var body: some View {
        Button(
            action: {
                self.showShareSheet = true
            },
            label: {
                Image(systemName: "square.and.arrow.up")
                    .accessibility(label: Text("Share Washroom"))
            }
        )
        .popover(isPresented: $showShareSheet) {
            ShareView(
                activityItems: [self.washroom.webURL],
                callback: {
                    self.showShareSheet = false
                }
            )
            .frame(idealWidth: 350, idealHeight: 600)
        }
    }
}

struct ShareButton_Previews: PreviewProvider {
    static var previews: some View {
        ShareButton(washroom: Washroom())
    }
}
