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
    private let controller = MapViewController()
    var startLocation: Location? = nil
    var interactive = true
    var buildings: [Building] = []
    
    func makeUIView(context: Context) -> UIView {
        controller.buildings = buildings
        controller.startLocation = startLocation
        controller.interactive = interactive
        
        return controller.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

struct MapUIView_Previews: PreviewProvider {
    static var previews: some View {
        MapUIView()
    }
}
