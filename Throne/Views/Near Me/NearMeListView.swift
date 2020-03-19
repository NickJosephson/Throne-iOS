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
    @Binding var currentListType: NearMeListType
    
    enum NearMeListType {
        case washrooms
        case buildings
    }
    
    var body: some View {
        List {
            Picker(selection: $currentListType, label: Text("List Type")) {
                Text("Buildings").tag(NearMeListType.buildings)
                Text("All \(settings.preferredTerm.capitalized)s").tag(NearMeListType.washrooms)
            }
            .pickerStyle(SegmentedPickerStyle())
            .navigationBarTitle(Text("Near Me"))
                        
            if currentListType == NearMeListType.washrooms {
                if nearMe.washrooms.count == 0 {
                    Text("No \(settings.preferredTerm.capitalized) Near You")
                    .foregroundColor(.secondary)
                    .navigationBarTitle(Text("Near Me"))
                }
                
                ForEach(nearMe.washrooms, id: \.self) { washroom in
                    WashroomRowView(washroom: washroom)
                }
                .navigationBarTitle(Text("Near Me"))
            } else {
                if nearMe.buildings.count == 0 {
                    Text("No Buildings Near You")
                    .foregroundColor(.secondary)
                    .navigationBarTitle(Text("Near Me"))
                }
                
                ForEach(nearMe.buildings.filter {
                    self.nearMe.filter.showEmptyBuildings || ($0.washroomsCount ?? 1) > 0
                }, id: \.self) { building in
                    BuildingRowView(building: building)
                }
                .navigationBarTitle(Text("Near Me"))
            }
        }
        .navigationBarTitle(Text("Near Me"))
        .navigationBarItems(leading: FilterButton(nearMe: self.nearMe))
    }
}

struct NearMeListView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeListView(nearMe: NearMe.shared, currentListType: .constant(.buildings))
    }
}
