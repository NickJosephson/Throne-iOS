//
//  SettingsView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings = UserSettings()
    
    var body: some View {
        Form {
            Picker(selection: $settings.preferredTerm, label: Text("Preferred Terminology")) {
                ForEach(preferredTermOptions.sorted(), id: \.self) { name in
                    Text(name)
                        .tag(name)
                }
            }
        }
        .navigationBarTitle(Text("Settings"))
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


