//
//  NearMeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeView: View {
    @ObservedObject private var nearMe = NearMe.shared
    @ObservedObject private var settings = PersistentSettings.shared
    @ObservedObject private var locationManager = LocationManager.shared
    @State private var currentListType = NearMeListView.NearMeListType.buildings
    
    var body: some View {
        NavigationView {
            if locationManager.currentLocation == nil {
                EnableLocationButton()
                    .navigationBarTitle(Text("Near Me"))
            } else {
                NearMeListView(currentListType: $currentListType)
                    .navigationBarTitle(Text("Near Me"))
            }
            
            if currentListType == .buildings {
                Text("No Building Selected")
                .foregroundColor(.secondary)
            } else {
                Text("No \(settings.preferredTerm.capitalized) Selected")
                .foregroundColor(.secondary)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct NearMeView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeView()
    }
}
