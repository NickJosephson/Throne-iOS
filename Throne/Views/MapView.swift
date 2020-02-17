//
//  MapView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        MapUIView().edgesIgnoringSafeArea(.all)
    }
}

struct MapUIView: UIViewRepresentable {
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
