//
//  WashroomDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomDetailView: View {
    var washroom: Washroom
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                ForEach([String](self.washroom.averageRatings.keys), id: \.self) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        Text("\(self.washroom.averageRatings[key]!)").foregroundColor(.secondary)
                    }
                }
            }
            Section() {
                NavigationLink(destination: Text("Amenities")) {
                    Text("Amenities")
                    Spacer()
                    ForEach(washroom.amenities, id: \.self) { amenity in
                        Text(amenity)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                NavigationLink(destination: Text("Reviews")) {
                    Text("Reviews")
                    Spacer()
                    Text("0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Section(header: Text("Location")) {
                NavigationLink(destination: MapView().edgesIgnoringSafeArea(.vertical).navigationBarTitle("Location", displayMode: .inline)) {
                    MapView()
                        .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: .center)
                        .cornerRadius(10)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(washroom.title)
        .navigationBarItems(trailing: Text("\(washroom.overallRating, specifier:"%.1f")").font(.largeTitle) )
    }
}

struct WashroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WashroomDetailView(washroom:  Washroom(id: 0, title: "test", location: Location(latitude: 0, longitude: 0), gender: .all, floor: 0, buildingID: 0, createdAt: Date(), overallRating: 0, averageRatings: [:], amenities: []))
    }
}
