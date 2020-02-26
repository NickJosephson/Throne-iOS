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
    var body: some View {
        NavigationView {
            MapUIView()
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MapPreviewView: View {
    let startLocation: Location
    
    var body: some View {
        MapUIView(startLocation: startLocation, interactive: false)
    }
}

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

struct MapUIView: UIViewRepresentable {
    let mapView = MKMapView()
    let location = CLLocationManager()
    var startLocation: Location? = nil
    var interactive = true
    
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
//            marker.title = "Washroom"
            marker.coordinate = CLLocationCoordinate2D(latitude: startLocation!.latitude, longitude: startLocation!.longitude)
            mapView.addAnnotation(marker)
            mapView.selectAnnotation(marker, animated: true)
        }
        
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
