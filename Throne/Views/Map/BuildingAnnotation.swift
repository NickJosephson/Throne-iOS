//
//  BuildingAnnotation.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-29.
//  Copyright © 2020 Throne. All rights reserved.
//

import Foundation
import MapKit

class BuildingAnnotation: NSObject, MKAnnotation {
    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D
    
    // Required if you set the annotation view's `canShowCallout` property to `true`
    var title: String?
    
    var subtitle: String?
    
    var building: Building
    
    init(_ building: Building) {
        coordinate = CLLocationCoordinate2D(building.location)
        self.title = building.title
        self.subtitle = building.stars
        self.building = building
    }
}
