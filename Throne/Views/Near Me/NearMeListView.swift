//
//  NearMeListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeListView: View {
    @ObservedObject var nearMe: NearMe
    @ObservedObject var settings = PersistentSettings.shared
    @State var currentListType = NearMeListType.buildings
    
    enum NearMeListType {
        case washrooms
        case buildings
    }
    
    var body: some View {
        List {
            Picker(selection: $currentListType, label: Text("List Type")) {
                Text("Buildings").tag(NearMeListType.buildings)
                Text("All Washrooms").tag(NearMeListType.washrooms)
            }
            .pickerStyle(SegmentedPickerStyle())
            .navigationBarTitle(Text("Near Me"))
                        
            if currentListType == NearMeListType.washrooms {
                if nearMe.washrooms.count == 0 {
                    Text("No \(settings.preferredTerm.capitalized) Near You")
                    .foregroundColor(.secondary)
                    .navigationBarTitle(Text("Near Me"))
                }
                
                ForEach(nearMe.washrooms, id: \.id) { washroom in
                    WashroomRowView(washroom: washroom)
                }
                .navigationBarTitle(Text("Near Me"))
            } else {
                if nearMe.buildings.count == 0 {
                    Text("No Buildings Near You")
                    .foregroundColor(.secondary)
                    .navigationBarTitle(Text("Near Me"))
                }
                
                ForEach(nearMe.buildings, id: \.title) { building in
                    BuildingRowView(building: building)
                }
                .navigationBarTitle(Text("Near Me"))
            }
        }
        .navigationBarTitle(Text("Near Me"))
    }
}

struct NearMeListView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeListView(nearMe: NearMe.shared)
    }
}
