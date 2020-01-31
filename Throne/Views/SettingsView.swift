//
//  SettingsView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var selectedTerm = 4
    
    var body: some View {
        Form {
            Picker(selection: $selectedTerm, label: Text("Preferred Terminology")) {
                ForEach(roomNames, id: \.self) { name in
                    Text(name)
                        .tag(roomNames.firstIndex(of: name)! + 1)
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

var roomNames = [
    "john",
    "crapper",
    "Eric's House",
    "latrine",
    "epic gamer room",
    "washroom",
    "bathroom",
    "toilet",
    "restroom",
    "lavatory",
    "powder room",
    "comfort station",
    "water closet",
    "privy",
    "loo",
    "can"
]
