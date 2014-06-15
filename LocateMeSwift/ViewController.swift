//
//  ViewController.swift
//  LocateMeSwift
//
//  Created by Antonio Gomez-Maldonado on 6/14/14.
//  Copyright (c) 2014 fractma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Main variables
    @IBOutlet var mapView : MKMapView
    let locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    // View loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        showUserLocation(self)
    }
    
    // Showing the user location
    func showUserLocation(sender : AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        
        //Asking for authorization to display current location
        if status == CLAuthorizationStatus.NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    // User authorized to show his current location
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        
        // Getting the user coordinates
        currentLocation = locationManager.location.coordinate
        
        // Setting the zoom region
        var zoomRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 250, 250)
        
        // Zoom the map to the current user location
        mapView.setRegion(zoomRegion, animated: true)
    }
    
    // User changed the authorization to use location
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // Request user authorization
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Error locating the user
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Erro locating the user: \(error)")
    }
    
    // Drop pin using curret user location
    @IBAction func dropPinInCurrentLocation(sender : AnyObject) {
        
        // Creating new annotation (pin)
        var currentAnnotation : MKPointAnnotation = MKPointAnnotation()
        
        // Annotation coordinates
        currentAnnotation.coordinate = currentLocation
        
        // Annotation title
        currentAnnotation.title = "Your Are Here!"
        
        // Adding the annotation to the map
        mapView.addAnnotation(currentAnnotation)
        
        // Displaying the pin title on drop
        mapView.selectAnnotation(currentAnnotation, animated: true)
    }

}

