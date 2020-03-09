//
//  EnableLocationButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct EnableLocationButton: View {
    var body: some View {
        Button(
            action: {
                // Open system preferences to Throne settings
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            },
            label: {
                Text("Enable Location")
            }
        )
        .padding()
        .foregroundColor(.white)
        .background(Color.green)
        .cornerRadius(10)
        .padding()
    }
}

struct EnableLocationButton_Previews: PreviewProvider {
    static var previews: some View {
        EnableLocationButton()
    }
}
