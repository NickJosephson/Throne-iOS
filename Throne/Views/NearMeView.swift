//
//  NearMeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeView: View {
    @ObservedObject var settings = PersistentSettings()
    @ObservedObject var model = NearMe()

    var body: some View {
        NavigationView {
            if model.currentLocation == nil {
                Button(action: {
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                }, label: { Text("Enable Location") })
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
                .padding()
                .navigationBarTitle(Text("Near Me"))
            } else {
                NearMeListView(model: model)
                .navigationBarTitle(Text("Near Me"))
            }
            Text("No \(settings.preferredTerm.capitalized) Selected")
            .foregroundColor(.secondary)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct NearMeListView: View {
    @ObservedObject var settings = PersistentSettings()
    @ObservedObject var model: NearMe
    @State var listTypeSelection = NearMeListTyle.washrooms
    
    enum NearMeListTyle {
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
                Picker(selection: $listTypeSelection, label: Text("List Type")) {
                    Text("Washrooms").tag(NearMeListTyle.washrooms)
                    Text("Buildings").tag(NearMeListTyle.buildings)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
                        
            if listTypeSelection == NearMeListTyle.washrooms {
                WashroomsListView(model: model)
            } else {
                BuildingsListView(model: model)
            }
        }
    }
}

struct WashroomsListView: View {
    @ObservedObject var model: NearMe
    
    var body: some View {
        ForEach(model.washrooms, id: \.title) { washroom in
            NavigationLink(destination: WashroomDetailView(washroom: washroom)) {
                VStack(alignment: .leading) {
                    Text(washroom.title)
                    RatingView(rating: washroom.overallRating)
                        .padding(.bottom)
                }
                .layoutPriority(1)
                Spacer()
                Text("\(washroom.distance, specifier:"%.1f")m")
                .foregroundColor(.secondary)
                .layoutPriority(2)
            }
        }.navigationBarTitle(Text("Near Me"))
    }
}

struct BuildingsListView: View {
    @ObservedObject var model: NearMe
    
    var body: some View {
        ForEach(model.buildings, id: \.title) { building in
            NavigationLink(destination: BuildingDetailView(building: building)) {
                VStack(alignment: .leading) {
                    Text(building.title)
                    RatingView(rating: building.overallRating)
                        .padding(.bottom)
                }
                .layoutPriority(1)
                Spacer()
                Text("\(building.distance, specifier:"%.1f")m")
                .foregroundColor(.secondary)
                .layoutPriority(2)
            }
        }.navigationBarTitle(Text("Near Me"))
    }
}

struct NearMeView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeView()
    }
}
