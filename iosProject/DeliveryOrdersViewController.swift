//
//  DeliveryOrdersViewController.swift
//  iosProject
//
//  Created by Puneet on 2017-12-30.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase

/*************************************************************************************
 Author: Puneet Kaur
 Purpose: Delivery Orders
 *************************************************************************************/

class DeliveryOrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var orders : NSDictionary = [:]
    var users = [String]()
    var address = [String]()
    var billTotal = [String]()
    var timeElapsed = [Double]()
    var store = [String]()
    var address_lat = [Double]()
    var address_long = [Double]()
    var store_lat = [Double]()
    var store_long = [Double]()
    //var orderList = [[OrderItem]]()
    var timestamp = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationLabel.text = "Your location: " + DRIVER_LOCATION
        self.getOrderInfoFromFirebase()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! DeliveryOrderCell
        cell.deliveryAddressLabel.text = self.address[indexPath.row]
        cell.orderByLabel.text = self.users[indexPath.row]
        cell.totalBillLabel.text=self.billTotal[indexPath.row]
        let date : Date = Date()
        cell.elapsedDurationLabel.text = String(date.minutes(from : (Date(timeIntervalSinceReferenceDate:self.timeElapsed[indexPath.row]/1000)))) + " minutes ago"
        cell.elapsedDurationLabel.textColor = UIColor.blue
        cell.address_lat = self.address_lat[indexPath.row]
        cell.address_long = self.address_long[indexPath.row]
        cell.store_lat = self.store_lat[indexPath.row]
        cell.store = self.store[indexPath.row]
        cell.storeAddress.text = self.store[indexPath.row]
        //cell.orders = self.orderList[indexPath.row]
        cell.timestamp = Int(self.timeElapsed[indexPath.row])
        return cell
    }
    
    
    func getOrderInfoFromFirebase()
    {
        FIREBASE.child("ORDER").queryOrderedByKey().observe(.childAdded, with:{
            snapshot in
            if snapshot.exists()
            {
                //sort the snapshot result by date
                let result = snapshot.value as! NSDictionary
                 //DispatchQueue.main.async {
                self.users.append(result.value(forKey: "user") as! String)
                self.address.append(result.value(forKey:"address") as! String)
                self.billTotal.append(result.value(forKey:"bill") as! String)
                self.address_lat.append(Double(result.value(forKey: "address_lat") as! Double))
                self.address_long.append(Double(result.value(forKey: "address_long") as! Double))
                self.store_lat.append(Double(result.value(forKey: "store_lat") as! Double))
                self.store_long.append(Double(result.value(forKey: "store_long") as! Double))
                self.store.append(result.value(forKey: "store_name") as! String)
                self.timeElapsed.append(Double(snapshot.ref.key)!)
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        })
        
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
extension Date{
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
}
}
