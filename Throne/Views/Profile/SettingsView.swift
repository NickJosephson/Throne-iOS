//
//  SettingsView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings = PersistentSettings.shared
    
    var body: some View {
        Form {
            Picker(selection: $settings.preferredTerm, label: Text("Preferred Terminology")) {
                ForEach(preferredTermOptions.sorted(), id: \.self) { name in
                    Text(name).tag(name)
                }
            }
            Section {
                Button(action: { LoginManager.shared.logout() }) {
                    Text("Log Out")
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


