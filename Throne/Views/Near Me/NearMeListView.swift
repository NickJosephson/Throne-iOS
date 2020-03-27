//
//  NearMeListView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-27.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeListView: View {
    @Binding var currentListType: NearMeListType
    @ObservedObject private var nearMe = NearMe.shared
    @ObservedObject private var settings = PersistentSettings.shared

    enum NearMeListType {
        case washrooms
        case buildings
    }
    
    var body: some View {
        List {
            Picker(selection: $currentListType, label: Text("List Type")) {
                Text("Buildings")
                    .tag(NearMeListType.buildings)
                Text("All \(settings.preferredTerm.capitalized)s")
                    .tag(NearMeListType.washrooms)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            if currentListType == NearMeListType.washrooms {
                if nearMe.washrooms?.count == 0 {
                    Text("No \(settings.preferredTerm.capitalized) Near You")
                        .foregroundColor(.secondary)
                }
                
                if nearMe.washrooms != nil {
                    ForEach(nearMe.washrooms!, id: \.self) { washroom in
                        WashroomRowView(washroom: washroom)
                    }
                } else {
                    SpinnerRowView()
                }
            } else {
                if nearMe.buildings?.count == 0 {
                    Text("No Buildings Near You")
                        .foregroundColor(.secondary)
                }
                
                if nearMe.buildings != nil {
                    ForEach(filter(buildings: nearMe.buildings!, by: nearMe.filter), id: \.self) { building in
                        BuildingRowView(building: building)
                    }
                } else {
                    SpinnerRowView()
                }
            }
        }
        .navigationBarItems(leading: FilterButton())
    }
    
    /// Return a filtered version of a given Building list.
    ///
    /// Most filtering is and should be done server side, but  to limit scope, some is being performed here.
    /// - Parameters:
    ///   - buildings: Building list to filter.
    ///   - filter: Filter to apply to list.
    func filter(buildings: [Building], by filter: Filter) -> [Building] {
        return buildings.filter {
            // Filter out empty buildings if specified by filter
            filter.showEmptyBuildings || ($0.washroomsCount ?? 1) > 0
        }
    }
}

struct NearMeListView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeListView(currentListType: .constant(.buildings))
    }
}
