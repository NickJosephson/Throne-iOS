//
//  MapView.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-30.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var model: NearMe
    
    var body: some View {
        MapUIView(buildings: model.buildings)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(model: NearMe())
    }
}
