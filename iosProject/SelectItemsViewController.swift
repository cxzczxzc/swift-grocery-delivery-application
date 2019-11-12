//
//  SelectItemsViewController.swift
//  iosProject
//
//  Created by Saad  on 2017-12-26.
//  Copyright © 2017 Xcode User. All rights reserved.
//

/***********************************************************************************
 Author: Saad Ahmad
 Purpose: Grocery Tableview
 *************************************************************************************/

import UIKit
import SwiftyJSON
import JHTAlertController
class SelectItemsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var sgmCategory: UISegmentedControl!
    
    //var cell : SiteCell = SiteCell()
    
    
    @IBAction func sgmCategoryChanged(_ sender: Any) {
        self.loadItems()
    }
    
    
    var categories = [String]()
    var items = [String]()
    var price = [String]()
    var imageURLS = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderButton.layer.cornerRadius = 5 
        storeLabel.text = STORE
        self.loadItems()
        orderArray.removeAll()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! SiteCell
        //to save Image URLS in item object and use in next screen
        cell.hiddenURLS.isHidden = true
        cell.hiddenURLS.text = self.imageURLS[indexPath.row]
        cell.itemLabel.text = items[indexPath.row]
        cell.priceLabel.text = "$"+price[indexPath.row]
        cell.price = Double(price[indexPath.row])!
        cell.index = indexPath.row
        cell.categoryLabel.text = sgmCategory.titleForSegment(at: sgmCategory.selectedSegmentIndex)
        let url = URL(string: self.imageURLS[indexPath.row])
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.itemImage.layer.borderColor = UIColor(red:0.47, green:0.16, blue:0.53, alpha:1.0).cgColor
                cell.itemImage.layer.borderWidth = 1
                cell.itemImage.layer.cornerRadius = cell.itemImage.frame.size.width/2
                cell.itemImage.layer.masksToBounds = true
                cell.itemImage.image = UIImage(data: data!)
            }
        }
        return cell

    }
    /***************************************************************************************************
     * Author: Saad Ahmad                                                                              *
     * This method ensures that the user has selected at least one item before placing the order       *
     * If the user has chosen some items, it displays a confirmation alert with number of items        *
     ***************************************************************************************************/
    @IBAction func orderButtonClicked(_ sender: Any) {
        if orderDetails.isEmpty
        {
            showAlert(title: "Empty Order", message: "Please make a selection before placing your order")
        }
        else
        {
            let message =  "Place order for " + String(orderDetails.count) + " items? You will see the summary on next screen."
            let alertController = JHTAlertController(title: "Order", message: message, preferredStyle: .alert)
            alertController.titleViewBackgroundColor = UIColor(red:0.20, green:0.13, blue:0.21, alpha:1.0)
            alertController.alertBackgroundColor = .black
            alertController.setButtonBackgroundColorFor(.default, to: .black)
              alertController.setButtonBackgroundColorFor(.cancel, to: .black)
            let cancelAction = JHTAlertAction(title: "Cancel", style: .cancel,  handler: nil)
            let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
                for (key, orders) in orderDetails {
                    orderArray.append(orders)
                }
                //present order confirmation screen
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfirmOrderViewController") as! ConfirmOrderViewController
                self.present(vc, animated: true, completion: nil)
                
            }
            // Add the actions to the alert.
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
           
        }
    }
    /***************************************************************************************************
     * Author: Saad Ahmad                                                                              *
     * This method queries various endpoints, based on category to populate the tableview              *
     * The tableview navigation is dependent upon the segmented view                                   *
     ***************************************************************************************************/
    func loadItems()
    {
        var myUrl : URL!
        //checks the select segment of segmented control and 
        //selects respective php file to retrive data from
        
        if(sgmCategory.selectedSegmentIndex==0){myUrl = URL(string: BAKERY_URL)!;}
        else if(sgmCategory.selectedSegmentIndex==1){myUrl = URL(string: FRUITS_URL)!;}
        else if(sgmCategory.selectedSegmentIndex==2){myUrl = URL(string: VEGETABLES_URL)!;}
        else if(sgmCategory.selectedSegmentIndex==3){myUrl = URL(string: DAIRY_URL)!;}
        else if(sgmCategory.selectedSegmentIndex==4){myUrl = URL(string: MEAT_URL)!;}
        else if(sgmCategory.selectedSegmentIndex==5){myUrl = URL(string: FROZEN_URL)!;}
        
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let json = JSON(data: data!)
            
            //removing all items from global arrays to display items per category 
            //using segmented control
            self.items.removeAll()
            self.price.removeAll()
            self.imageURLS.removeAll()
            
            for i in 0 ..< json.count  {
               self.items.append(json[i]["name"].stringValue)
               self.categories.append(json[i]["category"].stringValue)
               self.price.append(json[i]["price"].stringValue)
               self.imageURLS.append(json[i]["imageurl"].stringValue)
            }
            //print(self.imageURLS)
              OperationQueue.main.addOperation {
              self.tableView.reloadData()
            }
            
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmOrderView"{
            let nextView = segue.destination as! ConfirmOrderViewController
            //secondViewController.passedData = //data
        }
    }
    
    @IBAction func unwindToSelectItemsViewController(segue: UIStoryboardSegue){
        
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
