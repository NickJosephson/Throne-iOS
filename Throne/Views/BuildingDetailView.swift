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
                            RatingView(rating: .constant(washroom.overallRating))
                            .padding(.bottom)
                        }
                        .layoutPriority(1)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Floor \(washroom.floor)")
                            Text("\(washroom.gender.description)")
                        }
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.secondary)
                        .layoutPriority(2)
                    }
                }
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
        .navigationBarItems(trailing:
            Button(action: { self.showCreateWashroom = true }, label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Washroom")
                }
            })
            .popover(isPresented: $showCreateWashroom, content: { CreateWashroomView(show: self.$showCreateWashroom) } )
        )
    }

}

//struct BuildingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView()
//    }
//}
