//
//  DriverViewControllerExtension.swift
//  iosProject
//
//  Created by Puneet  on 2017-12-30.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps
import CoreLocation
/***********************************************************************
 *Author: Saad Ahmad                                                   *
 *This class adds a Google map to the driver home page programatically *
 *This class also implemenents the CLLocationManagerDelegate protocol  *
 *Which creates a singleton object for managing driver information     *
 ***********************************************************************/
extension DriverViewController{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
