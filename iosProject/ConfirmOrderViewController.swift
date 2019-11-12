//
//  ConfirmOrderViewController.swift
//  iosProject
//
//  Created by Puneet on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import UIKit
/***********************************************************************************
 Author:  Puneet Kaur
 Purpose: Final page before the order is placed
 *************************************************************************************/
class ConfirmOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblOrderTotal: UILabel!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    override func viewDidLoad() {
        btnPlaceOrder.layer.cornerRadius = 5
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.lblOrderTotal.text = "Order Total: $" + self.calculateTotal()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! FinalCell
        cell.lblItem.text = orderArray[indexPath.row].itemName
        cell.lblQuantity.text = String(orderArray[indexPath.row].itemQuantity)
        cell.lblItemPrice.text = "$" + String(orderArray[indexPath.row].itemPrice)
        cell.lblFinalPrice.text = "$" + String(orderArray[indexPath.row].finalPrice)
        
        //compute order total
        orderTotal = orderTotal + orderArray[indexPath.row].finalPrice
        
        let url = URL(string: orderArray[indexPath.row].itemURL)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.imgItem.layer.borderColor = UIColor(red:0.47, green:0.16, blue:0.53, alpha:1.0).cgColor
                cell.imgItem.layer.borderWidth = 1
                cell.imgItem.layer.cornerRadius = cell.imgItem.frame.size.width/2
                cell.imgItem.layer.masksToBounds = true
                cell.imgItem.image = UIImage(data: data!)
            }
        }
        return cell
    }
    /************************************************************************************
     *Author:  Puneet Kaur                                                              *
     *Purpose: Segue to AcceptedOrdersViewController                                    *
     ************************************************************************************/
    @IBAction func placeOrderButtonClicked(_ sender: UIButton) {
        addToFirebase()
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcceptedOrderViewController") as! AcceptedOrdersViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    /***********************************************************************************
     *Author:  Puneet Kaur                                                             *
     *Purpose: Construct a key value pair using the global variables of the application*
     * The key value pair is added to firebase                                         *
     ***********************************************************************************/
    func addToFirebase()
    {
            let post:[String : Any] = [
            "user" : USERNAME,
            "store_lat": STORE_LAT,
            "store_long": STORE_LONG,
            "store_name": STORE,
            "store_phone": STORE_PHONE,
            "bill":self.lblOrderTotal.text!,
            "address": ADDRESS,
            "address_lat": ADDRESS_LAT,
            "address_long": ADDRESS_LONG
        ]
        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate*1000)
        TIMESTAMP = timestamp
        WATCH_TIMESTAMP = String(timestamp)
        FIREBASE.child(PARENT_KEY).child(String(timestamp)).setValue(post)
        for order in orderArray
        {
            order.saveToFirebase(timestamp: String(timestamp))
        }
        
    }
    /*************************************************************************************
     *Author:  Puneet Kaur                                                               *
     *Purpose: Calculate the total price of the order                                    *
     *************************************************************************************/
    
    func calculateTotal() -> String
    {
        var total = 0.0
        for i in 0 ..< orderArray.count  {
           total =  total + orderArray[i].finalPrice
        }
        return String(total)
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
