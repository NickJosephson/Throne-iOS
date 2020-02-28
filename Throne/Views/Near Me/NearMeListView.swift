//
//  NearMeListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeListView: View {
    @ObservedObject var settings = PersistentSettings()
    @ObservedObject var model: NearMe
    @State var currentListType = NearMeListType.washrooms
    
    enum NearMeListType {
        case washrooms
        case buildings
    }
    
    var body: some View {
        List {
            if model.washrooms.count == 0 {
                Text("No \(settings.preferredTerm.capitalized) Near You")
                .foregroundColor(.secondary)
                .navigationBarTitle(Text("Near Me"))
            } else {
                Picker(selection: $currentListType, label: Text("List Type")) {
                    Text("Washrooms").tag(NearMeListType.washrooms)
                    Text("Buildings").tag(NearMeListType.buildings)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
                        
            if currentListType == NearMeListType.washrooms {
                WashroomsListView(washrooms: model.washrooms)
                .navigationBarTitle(Text("Near Me"))
            } else {
                BuildingsListView(model: model)
                .navigationBarTitle(Text("Near Me"))
            }
        }
    }
}

struct NearMeListView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeListView(model: NearMe())
    }
}
