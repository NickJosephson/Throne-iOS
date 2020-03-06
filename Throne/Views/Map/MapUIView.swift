//
//  MapUIView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-29.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapUIView: UIViewControllerRepresentable {
    var startLocation: Location? = nil
    var interactive = true
    var buildings: [Building] = []
    var showsUserLocation = true
    
    func makeUIViewController(context: Context) -> MapViewController {
        let uiViewController = MapViewController()
        uiViewController.buildings = buildings
        uiViewController.startLocation = startLocation
        uiViewController.interactive = interactive
        uiViewController.showsUserLocation = showsUserLocation
        return uiViewController
    }

    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        uiViewController.buildings = buildings
        uiViewController.startLocation = startLocation
        uiViewController.interactive = interactive
        uiViewController.showsUserLocation = showsUserLocation
    }

}

struct MapUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapUIView()
    }
}
