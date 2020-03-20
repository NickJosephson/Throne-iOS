//
//  MapView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct MapView: View {
    @ObservedObject private var nearMe = NearMe.shared
    
    var body: some View {
        MapUIView(buildings: nearMe.buildings)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
