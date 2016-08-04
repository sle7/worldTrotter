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
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        let button = UIButton(type: .System)
        button.setTitle("Loc", forState: .Normal)
        button.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(MapViewController.showLocButton(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
        
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
    
    func showLocButton (sender: UIButton!){
        locManager = CLLocationManager()
        let locationAuthStatus = CLLocationManager.authorizationStatus()
        if locationAuthStatus == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.Follow, animated: true)
        } else {
            locManager.requestWhenInUseAuthorization()
        }
        
    }
    
}
