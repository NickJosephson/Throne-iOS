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
        ZStack(alignment: .topTrailing) {
            MapUIView().edgesIgnoringSafeArea(.all)
            Button(action: {}) {
                Image(systemName: "location.fill")
                    .font(.headline)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding()
            
        }
        
            
    }
}

struct MapUIView: UIViewRepresentable {
    let mapView = MKMapView()
    let location = CLLocationManager()
    
    func makeUIView(context: Context) -> MKMapView {
        location.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.showsBuildings = true
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
//
//class MapViewController: UIViewController {
//    let mapView = MKMapView()
//    let location = CLLocationManager()
//
//    override func viewDidLoad() {
//         location.requestWhenInUseAuthorization()
//         mapView.showsUserLocation = true
//         mapView.showsCompass = true
//         mapView.showsBuildings = true
//         let buttonItem = MKUserTrackingBarButtonItem(mapView: mapView)
//         mapView.navigationItem.rightBarButtonItem = buttonItem
//    }
//}
