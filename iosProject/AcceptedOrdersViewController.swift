//
//  AcceptedOrdersViewController.swift
//  iosProject
//
//  Created by Saad  on 2017-12-30.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/*************************************************************************************
 Author: Saad
 Purpose: Shows the page where the user waits for order to be accepted
 *************************************************************************************/
import UIKit
import CoreLocation
import SpriteKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON
class AcceptedOrdersViewController: UIViewController, GMSMapViewDelegate{

    var scene: Animation?
    @IBOutlet weak var checkStatusButton: UIButton!
    @IBOutlet weak var getdistance: UIButton!
    @IBOutlet weak var totalDistance: UILabel!
    @IBOutlet weak var ETALabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet var sceneView: SKView!
    @IBOutlet var mapView : GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    let defaultLocation = CLLocation(latitude: ADDRESS_LAT, longitude: ADDRESS_LONG)
    override func viewDidLoad() {
    checkStatusButton.layer.cornerRadius = 5
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        self.getDriver()
        self.scene = Animation(size: CGSize(width: self.sceneView.frame.size.width, height: self.sceneView.frame.size.height))
        self.sceneView.presentScene(scene)
        // Do any additional setup after loading the view.
        self.mapView.camera = camera
        self.mapView.delegate = self
        createMarker(title: "Your Location", lat: ADDRESS_LAT, long: ADDRESS_LONG)
        createMarker(title: "Store Location", lat: STORE_LAT, long: STORE_LONG)
       // self.createPolylineFromStore()
        
    }
    
    func createMarker(title: String, lat: CLLocationDegrees, long : CLLocationDegrees)
    {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(lat, long)
        marker.title = title
        marker.map = self.mapView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func getDriver()
    {
        FIREBASE.child("ORDER").child(String(TIMESTAMP)).child("driver").observe(.childAdded, with:{  snapshot in
            if snapshot.exists()
            {
                //sort the snapshot result by date
                let result = snapshot.key
                if result == "driver_name"{
                    DRIVER = (snapshot.value as! String)
                self.driverLabel.text = "Your driver is " + DRIVER
                    if let scene = self.scene{
                        scene.move()
                    }
                }
                if result == "driver_lat"
                {
                    
                    DRIVER_LAT = snapshot.value as! Double
                    
                }
                if result == "driver_long"
                {
                    DRIVER_LONG = snapshot.value as! Double
                }
            }
        })
    }
    func calculateDistance(lat1 : Double, long1: Double, lat2: Double, long2: Double) -> Double
    {
        let to = CLLocation(latitude: lat1, longitude: long1)
        let from = CLLocation(latitude: lat2, longitude: long2)
        print(from)
        print(to)
        let distanceInMeters = to.distance(from: from)
        return distanceInMeters
    }
    
    func getTotalDistance()->Double
    {
        let d1 = self.getDistanceToHomeFromStore()
        let d2 = self.getDistanceToStoreFromDriver()
        let totalDistanceInKM = (d1+d2)/1000
        let roundedDistance = Double(round(100*totalDistanceInKM)/100)
        return roundedDistance
    }
    
    func getDistanceToHomeFromStore() -> Double
    {
        let distanceToHomeFromStore = self.calculateDistance(lat1: STORE_LAT, long1: STORE_LONG, lat2: ADDRESS_LAT, long2: ADDRESS_LONG)
        return distanceToHomeFromStore
        
    }
    func getDistanceToStoreFromDriver() -> Double
    {
        let distanceToStoreFromDriver = self.calculateDistance(lat1: DRIVER_LAT, long1: DRIVER_LONG, lat2: STORE_LAT, long2: STORE_LONG)
        
         return distanceToStoreFromDriver
    }
    func getETA() -> String
    {
        let distance = self.getTotalDistance()
        let eta = Int((distance/70) * 60)
        if eta >= 60
        {
            return String(eta/60) + " hours"
        }
        EST_TIME = String(eta) + " minutes"
        return String(eta) + " minutes"
    }

    @IBAction func getStatusButtonClicked(_ sender: Any) {
        if (self.driverLabel.text?.contains("Waiting"))!{
            ORDER_STATUS = "Submitted"
            showAlert(title: "Please Wait", message: "Wait for a driver to accept the delivery request" )
        }
        else
        {
            showAlert(title: "Delivery Status", message: "The driver is " + String(self.getTotalDistance()) + " KM far. Your order will arrive in about " + self.getETA())
            let cam = GMSCameraPosition.camera(withLatitude: DRIVER_LAT,
                                                  longitude: DRIVER_LONG,
                                                  zoom: zoomLevel)
            self.mapView.camera = cam
            self.mapView.reloadInputViews()
            self.createMarker(title: "Driver's Location", lat: DRIVER_LAT, long: DRIVER_LONG)
            self.createPolyline()
            self.saveTimeAndDistanceInfo(timestamp: TIMESTAMP)
        }
    }
    func createPolyline()
    {
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: ADDRESS_LAT, longitude: ADDRESS_LONG))
        path.add(CLLocationCoordinate2D(latitude: STORE_LAT, longitude: STORE_LONG))
        path.add(CLLocationCoordinate2D(latitude: DRIVER_LAT, longitude: DRIVER_LONG))
        /* show what you have drawn */
        let rectangle = GMSPolyline(path: path)
        rectangle.map = mapView

    }
    func saveTimeAndDistanceInfo(timestamp : Int)
    {
        let store = STORE
        let driver =  DRIVER
        let eta = self.getETA()
        
        let myUrl = URL(string: DISTANCE_TIME_URL);
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "POST"
        //look at the error message
        let postString1 = "timestamp="+String(timestamp)+"&eta="
        let postString2 = eta+"&driver="+driver+"&store="+store;
        let postString = "\(postString1) \(postString2)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let json = JSON(data: data!)
            let message = json["message"].stringValue
            print(message)
            //return message from server indicating success or failure
            if error != nil
            {
                print("error=\(error)")
            }
        }
        task.resume()
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
