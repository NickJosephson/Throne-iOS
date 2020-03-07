//
//  BuildingDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-26.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct BuildingDetailView: View {
    @ObservedObject var building: Building
    @ObservedObject var settings = PersistentSettings.shared
    
    init(building: Building) {
        self.building = building
        building.setupWashroomsSubscription()
    }
    
    var body: some View {
        List {
            Section(header: Text("Washrooms Inside")) {
                if building.washrooms.count == 0 {
                    Text("No \(settings.preferredTerm.capitalized) Inside")
                    .foregroundColor(.secondary)
                }
                
                ForEach(building.washrooms, id: \.id) { washroom in
                    WashroomRowView(washroom: washroom, showBuilding: false)
                }
            }
            Section(header: Text("Location")) {
                NavigationLink(destination: MapDetailView(startLocation: building.location)) {
                    MapPreviewView(startLocation: building.location)
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                        .cornerRadius(10)
                }.accessibility(label: Text("Location on map"))
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("\(building.title)", displayMode: .large)
        .navigationBarItems(trailing: CreateWashroomButton(building: self.building))
    }
}

struct BuildingDetailView_Previews: PreviewProvider {
    static var previews: some View {        
        BuildingDetailView(building: Building())
    }
}
