//
//  MapView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    let startLocation: Location?
    
    var body: some View {
        MapUIView(startLocation: startLocation).edgesIgnoringSafeArea(.all)
    }
}

struct MapUIView: UIViewRepresentable {
    let mapView = MKMapView()
    let location = CLLocationManager()
    let startLocation: Location?

    func makeUIView(context: Context) -> MKMapView {
        location.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.showsBuildings = true
//        mapView.mapType = .hybrid
        if startLocation != nil {
//            mapView.setCenter(CLLocationCoordinate2D(latitude: startLocation!.latitude, longitude: startLocation!.longitude), animated: false)
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startLocation!.latitude, longitude: startLocation!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: false)
            let marker = MKPointAnnotation()
            marker.title = "Washroom"
            marker.coordinate = CLLocationCoordinate2D(latitude: startLocation!.latitude, longitude: startLocation!.longitude)
            mapView.addAnnotation(marker)
        }
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(startLocation: nil)
    }
}
