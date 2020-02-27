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
    @State private var showCreateWashroom = false
    
    init(building: Building) {
        self.building = building
        building.fetchWashrooms()
    }
    
    var body: some View {
        List {
            Section(header: Text("Washrooms Inside")) {
                ForEach(building.washrooms, id: \.title) { washroom in
                    NavigationLink(destination: WashroomDetailView(washroom: washroom)) {
                        VStack(alignment: .leading) {
                            Text(washroom.title)
                            HStack {
                                ForEach(washroom.amenities.filter { $0.emoji != nil } , id: \.self) { amenity in
                                    Text(amenity.emoji!).font(.subheadline).foregroundColor(.secondary)
                                }
                            }
                        }
                        .layoutPriority(1)
                        Spacer()
                        Text("\(washroom.overallRating, specifier:"%.1f")").font(.largeTitle)
                        .layoutPriority(2)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("\(building.title)", displayMode: .large)
        .navigationBarItems(trailing:
            Button(action: { self.showCreateWashroom = true }, label: { Image(systemName: "plus") })
                .sheet(isPresented: $showCreateWashroom, content: { CreateWashroomView(show: self.$showCreateWashroom) } )
        )
    }

}

//struct BuildingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView()
//    }
//}
