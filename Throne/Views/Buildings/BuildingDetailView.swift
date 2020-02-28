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
    
    init(building: Building) {
        self.building = building
        building.fetchWashrooms()
    }
    
    var body: some View {
        List {
            Section(header: Text("Washrooms Inside")) {
                WashroomsListView(washrooms: building.washrooms)
            }
            Section(header: Text("Location")) {
                NavigationLink(destination: MapDetailView(startLocation: building.location)) {
                    MapPreviewView(startLocation: building.location)
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                        .cornerRadius(10)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("\(building.title)", displayMode: .large)
        .navigationBarItems(trailing: CreateWashroomButton())
    }
}

struct BuildingDetailView_Previews: PreviewProvider {
    static var previews: some View {        
        BuildingDetailView(building: Building())
    }
}