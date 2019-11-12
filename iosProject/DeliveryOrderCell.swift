//
//  DeliveryOrderCell.swift
//  iosProject
//
//  Created by Puneet on 2017-12-30.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

/******************************************************************************
 Author: Puneet Kaur
 Purpose: Used to handle driver's tableview -> populating it in real time
 ******************************************************************************/
class DeliveryOrderCell: UITableViewCell {
    
    @IBOutlet weak var orderByLabel: UILabel!
    @IBOutlet weak var deliveryAddressLabel: UILabel!
    @IBOutlet weak var deliverButton: UIButton!
    @IBOutlet weak var totalBillLabel: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var elapsedDurationLabel: UILabel!
    var address_lat = 0.0
    var address_long = 0.0
    var store_lat = 0.0
    var store_long = 0.0
    var store = ""
    var orders = [OrderItem]()
    var timestamp=0
    
    @IBOutlet weak var acceptedLabel: UILabel!
    
    /**********************************************************************************************
     *    Author: Puneet Kaur                                                                     *
     *    This method adds driver's information (name, location) to Firebase                      *
     *    Items are added in Firebase based on key-value pairs, these key value pairs are         *
     *    uniquely identified by a timestamp value of the time when the order was placed          *
     *    The timestamp value is stored for each cell and the method will take the timestamp      *
     *    associated with that cell and add driver information to Firebase                        *
     **********************************************************************************************/
    
    @IBAction func deliveryButton(_ sender: Any) {
        acceptedLabel.text = "Accepted!"
        let driver_lat = DRIVER_LAT
        let driver_long = DRIVER_LONG
        print(driver_long)
        ADDRESS_LAT = self.address_lat
        ADDRESS_LONG = self.address_long
        STORE_LAT = self.store_lat
        STORE_LONG = self.store_long
        STORE = self.store
        print(DRIVER_LAT)
        print(DRIVER_LOCATION)
        print(STORE)
        TIMESTAMP = self.timestamp
        acceptedLabel.textColor = UIColor.green
        let ref = FIREBASE.ref.child("ORDER").child(String(self.timestamp)).child("driver")
        let dict = ["driver_name" : USERNAME, "driver_lat": driver_lat, "driver_long" : driver_long] as [String : Any]
        ref.setValue(dict)
    }

}
