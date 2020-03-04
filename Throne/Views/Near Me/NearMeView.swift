//
//  NearMeView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct NearMeView: View {
    @ObservedObject var settings = PersistentSettings.shared
    @ObservedObject var locationManager = LocationManager.shared
    @ObservedObject var model: NearMe

    var body: some View {
        NavigationView {
            if locationManager.currentLocation == nil {
                EnableLocationButton()
                .navigationBarTitle(Text("Near Me"))
            } else {
                NearMeListView(nearMe: model)
                .navigationBarTitle(Text("Near Me"))
            }
            
            Text("No \(settings.preferredTerm.capitalized) Selected")
            .foregroundColor(.secondary)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct NearMeView_Previews: PreviewProvider {
    static var previews: some View {
        NearMeView(model: NearMe.shared)
    }
}
