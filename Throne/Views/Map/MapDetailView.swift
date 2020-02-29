//
//  MapDetailView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-29.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    let startLocation: Location
    
    var body: some View {
        MapUIView(startLocation: startLocation)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Location", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                let item = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(self.startLocation)))
                item.openInMaps(launchOptions: nil)
            } , label: { Text("Open in Maps") }))
    }
}


struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView(startLocation: Location(latitude: 0, longitude: 0))
    }
}
