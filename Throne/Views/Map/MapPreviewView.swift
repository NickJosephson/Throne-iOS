//
//  MapPreviewView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-29.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct MapPreviewView: View {
    let startLocation: Location
    
    var body: some View {
        MapUIView(startLocation: startLocation, interactive: false, showsUserLocation: false)
    }
}

struct MapPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        MapPreviewView(startLocation: Location(latitude: 0, longitude: 0))
    }
}
