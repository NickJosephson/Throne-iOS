//
//  WashroomDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct WashroomDetailView: View {
    var room: Room
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                HStack {
                    Text("✨ Cleanliness")
                    Spacer()
                    Text("Good").foregroundColor(.secondary)
                }
                HStack {
                    Text("🤚 Privacy")
                    Spacer()
                    Text("Excelent").foregroundColor(.secondary)
                }
                HStack {
                    Text("🧻 Paper Quality")
                    Spacer()
                    Text("Poor").foregroundColor(.secondary)
                }
                HStack {
                    Text("👃 Smell")
                    Spacer()
                    Text("Fair").foregroundColor(.secondary)
                }
                HStack {
                    Text("🦽 Accessibility")
                    Spacer()
                    Text("Good").foregroundColor(.secondary)
                }
            }
            Section() {
                NavigationLink(destination: Text("Test")) {
                    Text("Amenities")
                    Spacer()
                    ForEach(room.amenities, id: \.self) { amenity in
                        Text(amenity)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                NavigationLink(destination: Text("Test")) {
                    Text("Reviews")
                    Spacer()
                    Text("10")
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
        .navigationBarTitle(room.title)
        .navigationBarItems(trailing: Text(room.rating).font(.largeTitle) )
    }
}

struct WashroomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WashroomDetailView(room: Room(title: "Test Room", amenities: [], rating: ""))
    }
}
