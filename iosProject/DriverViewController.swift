//
//  DriverViewController.swift
//  iosProject
//
//  Created by Puneet on 2017-12-29.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces
/*************************************************************************************
 Author:  Saad Ahmad
 Purpose: Final page before the order is placed
 *************************************************************************************/
class DriverViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var lblWelcome: UILabel!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
     let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLocationManager()
        placesClient = GMSPlacesClient.shared()
        lblWelcome.text = ("Welcome, "+USERNAME)
        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        let frame: CGRect = view.frame
        let mapFrame : CGRect =  CGRect(origin: CGPoint(x: 0,y :45), size: CGSize(width: frame.size.width*0.9, height: frame.size.height*0.7))
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //mapView.isMyLocationEnabled = true
        
        // Add the map to the view, hide it until we've got a location update.
        let marker = GMSMarker(position: (locationManager.location?.coordinate)!)
        self.getCurrentLocation(locationName: {location in
            DispatchQueue.main.async {
    
        marker.title = "Your Location"
                marker.snippet = location
            }
         })
        marker.map = mapView
        mapView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(mapView)
        mapView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*************************************************************************************
     Author:  Saad Ahmad
     Purpose: Get location from Google Places API
     *************************************************************************************/
    func getCurrentLocation(locationName: @escaping (String) -> Void) -> ()
    {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                for likelihood in placeLikelihoodList.likelihoods {
                    let place = likelihood.place
                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
                    print("Current Place address \(place.formattedAddress)")
                    print("Current Place attributions \(place.attributions)")
                    print("Current PlaceID \(place.placeID)")
                     DispatchQueue.main.async {
                    DRIVER_LAT = place.coordinate.latitude
                    DRIVER_LONG = place.coordinate.longitude
                    DRIVER_ADDRESS = place.formattedAddress!
                    DRIVER_LOCATION = place.name
                    locationName(DRIVER_LOCATION)
                    }
                    break
                }
            }
        })
    }
    func setupLocationManager()
    {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        DRIVER_LAT = (locationManager.location?.coordinate.latitude)!
        DRIVER_LONG = (locationManager.location?
            .coordinate.longitude)!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
