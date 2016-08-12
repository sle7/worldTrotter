//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Sam Lee on 7/25/16.
//  Copyright © 2016 Sam Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var locManager: CLLocationManager!
    
    @IBOutlet weak var button: UIButton!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
       
        // Create localized segmented control and add properties
        let standardString  = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid mapview")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), forControlEvents: .ValueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Add segmented control to map subview
        view.addSubview(segmentedControl)
       
        // Set constraints for segmented control
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
       
        // Create button for user location
        let button = UIButton(type: .System)
        button.setTitle("Loc", forState: .Normal)
        button.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(MapViewController.showUserLoc(_:)), forControlEvents: .TouchUpInside)
       
        // Add button to map subview
        view.addSubview(button)
       
        // Set constraints for segmented control
        let topButtonConstraint = button.topAnchor.constraintEqualToAnchor(segmentedControl.bottomAnchor, constant: 8)
        let leadingButtonConstraint = button.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingButtonConstraint = button.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topButtonConstraint.active = true
        leadingButtonConstraint.active = true
        trailingButtonConstraint.active = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    /*
     mapTypeChanged - Change map type depending on which button is clicked on segmented control
    */
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    /*
     showUserLoc - Ask user for location authorization if necessary and show user location
    */
    func showUserLoc (sender: UIButton!){
        locManager = CLLocationManager()
        let locationAuthStatus = CLLocationManager.authorizationStatus()
        // If authorized, show user location and follow. Else ask for authorization
        if locationAuthStatus == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.Follow, animated: true)
        } else {
            locManager.requestWhenInUseAuthorization()
        }
        
    }
    
}
