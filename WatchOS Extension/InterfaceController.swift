//
//  InterfaceController.swift
//  WatchOS Extension
//
//  Created by Puneet Kaur on 2017-12-31.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import SwiftyJSON

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    

    var timeLocationData : [NSDictionary]?
    
    @IBAction func driverButtonPressed() {
        self.getTimestampData(timestamp: 2147483647, completionHandler:{message,
            data in
            if message == "true" {
                let order = FinalOrderModelModel(data: data)
                let m  = String(describing: "Your driver is : "+String(order!.driver))
                self.showPopup(message: m)
            }
            else
            {
                print("something went wrong")
            }
        }
        )
    }
    
    @IBAction func storeButtonPressed() {
        
        self.getTimestampData(timestamp: 2147483647, completionHandler:{message,
            data in
            if message == "true" {
                let order = FinalOrderModelModel(data: data)
                let m  = String(describing: "Store is : "+String(order!.store))
                self.showPopup(message: m)
            }
            else
            {
                print("something went wrong")
            }
        }
        )
    }
    
    @IBAction func timeButtonPressed() {

        self.getTimestampData(timestamp: 2147483647, completionHandler:{message,
            data in
            if message == "true" {
                let order = FinalOrderModelModel(data: data)
                let m  = String(describing: "Estimated Time: "+String(order!.eta))
                self.showPopup(message: m)
            }
            else
            {
                print("something went wrong")
            }
        }
        )
    }
    
   
    enum JSONError : String, Error{
        case NoData = "Error : No Data"
        case ConversionFailed = "Error : conversion from Json failed"
    }
    
    
    func showPopup(message:String){
        
        let h0 = { print("ok")}
        
        let action1 = WKAlertAction(title: "Okay", style: .default, handler:h0)
//        let action2 = WKAlertAction(title: "Decline", style: .destructive) {}
//        let action3 = WKAlertAction(title: "Cancel", style: .cancel) {}
        
        presentAlert(withTitle: message, message: "", preferredStyle: .actionSheet, actions: [action1])
    
    }
    
    func getTimestampData(timestamp: Int, completionHandler : @escaping (String, Data) -> Void) -> ()
    {
        
        let myUrl = URL(string: GET_DISTANCE_TIME_URL); 
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        let postString = "timestamp=2147483647";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if data != nil{
            let json = JSON(data: data!)
            let message = json["message"].stringValue
            completionHandler(message, data!)
           // print(json["driver"].stringValue)
            }
           
            if error != nil
            {
                print("error=\(error)")
            }
        }
        task.resume()
    }


    //Implement the watch connectivity delegate interface and methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
