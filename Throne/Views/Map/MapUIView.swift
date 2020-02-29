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

struct MapUIView: UIViewRepresentable {
    let mapView = MKMapView()
    let location = CLLocationManager()
    var startLocation: Location? = nil
    var interactive = true
    var buildings: [Building]?
    
    
    func makeUIView(context: Context) -> MKMapView {
        location.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.isUserInteractionEnabled = interactive
        mapView.showsBuildings = true
        mapView.mapType = .standard
        
        if startLocation != nil {
            mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: startLocation!.latitude, longitude: startLocation!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)), animated: false)
            let marker = MKPointAnnotation()
            marker.coordinate = CLLocationCoordinate2D(latitude: startLocation!.latitude, longitude: startLocation!.longitude)
            mapView.addAnnotation(marker)
            mapView.selectAnnotation(marker, animated: true)
        }
                
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct MapUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapUIView()
    }
}
