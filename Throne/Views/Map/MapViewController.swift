//
//  MapViewController.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-02-29.
//  Copyright © 2020 Throne. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit

class MapViewController: UIViewController {
    private let mapView = MKMapView()
    var buildingDetailNavigationController: UINavigationController!

    var buildings: [Building] = [] {
        didSet {
            addAnnotations(for: buildings)
        }
    }
    
    var startLocation: Location? {
        didSet {
            if let startLocation = startLocation {
                dropPinAndCenterOn(location: startLocation)
            }
        }
    }
    
    var interactive = true {
        didSet {
            mapView.isUserInteractionEnabled = interactive
        }
    }
    
    var showsUserLocation = true {
        didSet {
            mapView.showsUserLocation = showsUserLocation
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = showsUserLocation
        mapView.showsCompass = false
        mapView.isUserInteractionEnabled = interactive
        mapView.showsBuildings = true
        mapView.mapType = .standard
        mapView.delegate = self
        
        registerMapAnnotationViews()
        
        if let startLocation = startLocation {
            dropPinAndCenterOn(location: startLocation)
        } else {
            centerOnCurrentLocation()
        }
        
        addAnnotations(for: buildings)
        
        self.view = mapView
    }
    
    func dropPinAndCenterOn(location: Location) {
        mapView.setRegion(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(location),
                span: MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
            ),
            animated: false
        )
        let marker = MKPointAnnotation()
        marker.coordinate = CLLocationCoordinate2D(location)
        mapView.addAnnotation(marker)
        mapView.selectAnnotation(marker, animated: true)
    }
    
    func centerOnCurrentLocation() {
        if let currentLocation = LocationManager.shared.currentLocation {
            mapView.setRegion(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(currentLocation),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ),
                animated: false
            )
        }
    }
    
    func addAnnotations(for buildings: [Building]) {
        var annotations: [MKAnnotation] = []
        
        for building in buildings {
            let marker = BuildingAnnotation(building)
            annotations.append(marker)
        }

        mapView.addAnnotations(annotations)
    }
    
    /// Register the annotation views with the `mapView` so the system can create and efficiently reuse the annotation views.
    /// - Tag: RegisterAnnotationViews
    private func registerMapAnnotationViews() {
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(BuildingAnnotation.self))
    }

}

extension MapViewController: MKMapViewDelegate {

    /// The map view asks `mapView(_:viewFor:)` for an appropriate annotation view for a specific annotation.
    /// - Tag: CreateAnnotationViews
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        var annotationView: MKAnnotationView?

        if let annotation = annotation as? BuildingAnnotation {
            annotationView = setupBuildingAnnotationView(for: annotation, on: mapView)
        }
        
        return annotationView
    }
    
    @objc func dismissPopover() {
        self.buildingDetailNavigationController?.dismiss(animated: true, completion: {})
    }
    
    /// Called when the user taps the disclosure button in the bridge callout.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // This illustrates how to detect which annotation type was tapped on for its callout.
        if let annotation = view.annotation as? BuildingAnnotation {
            NSLog("Tapped annotation accessory view")

            let buildingDetailView = BuildingDetailView(building: annotation.building)
            
            let buildingDetailController = UIHostingController(rootView: buildingDetailView)
            self.buildingDetailNavigationController = UINavigationController(rootViewController: buildingDetailController)
            self.buildingDetailNavigationController.navigationBar.prefersLargeTitles = true
            self.buildingDetailNavigationController.modalPresentationStyle = .popover
            
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPopover))
            self.buildingDetailNavigationController.topViewController?.navigationItem.leftBarButtonItem = doneButton
            
            let presentationController = self.buildingDetailNavigationController.popoverPresentationController
            presentationController?.permittedArrowDirections = .any

            // Anchor the popover to the button that triggered the popover.
            presentationController?.sourceRect = control.frame
            presentationController?.sourceView = control
            
            self.present(buildingDetailNavigationController, animated: true, completion: nil)
        }
    }
    
    /// The map view asks `mapView(_:viewFor:)` for an appropriate annotation view for a specific annotation. The annotation
    /// should be configured as needed before returning it to the system for display.
    /// - Tag: ConfigureAnnotationViews
    private func setupBuildingAnnotationView(for annotation: BuildingAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        let reuseIdentifier = NSStringFromClass(BuildingAnnotation.self)
        let flagAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
        
        flagAnnotationView.canShowCallout = true
        flagAnnotationView.displayPriority = .defaultHigh
        flagAnnotationView.displayPriority = .init(Float(annotation.building.overallRating) + 0.5)

        let image: UIImage
        if annotation.building.overallRating <= 0 {
            image = #imageLiteral(resourceName: "building")
        } else if annotation.building.overallRating <= 1.5 {
            image = #imageLiteral(resourceName: "skull")
        } else if annotation.building.overallRating <= 2.5 {
            image = #imageLiteral(resourceName: "poo")
        } else if annotation.building.overallRating <= 4.0 {
            image = #imageLiteral(resourceName: "paper")
        } else {
            image = #imageLiteral(resourceName: "crown")
        }
        flagAnnotationView.image = image
        
        let rightButton = UIButton(type: .detailDisclosure)
        flagAnnotationView.rightCalloutAccessoryView = rightButton
        
        return flagAnnotationView
    }

}
