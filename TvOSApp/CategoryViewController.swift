//
//  CategoryViewController.swift
//  iosProject
//
//  Created by Surbhi Handa on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/***********************************************************************************
 Author: Surbhi Handa
 Purpose: Contains PHP endpoints and logic for parsing the JSON data
 *************************************************************************************/
import UIKit
import SwiftyJSON


class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var BAKERY_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/bakery.php"
    var MEAT_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/meat.php"
    var FRUITS_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/fruit.php"
    let VEGETABLES_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/vegetable.php"
    let FROZEN_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/frozen.php"
    let DAIRY_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/diary.php"

    @IBOutlet var imgCategory : UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    let GROCERY_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/grocery.php"
    
    @IBOutlet var lblCategory: UILabel!
    
    
    var categories = [String]()
    var items = [String]()
    var price = [String]()
    var imageURLS = [String]()
    
    let productData = CategoryProducts()

    func updateCategory(select : Int)
    {
        imgCategory.image = UIImage(named: productData.category[select])
        lblCategory.text = productData.categoryNames[select]
        self.loadItems()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // this will display the image for each item and name of each item in each cell as per the category chosen
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TvSiteCell
        cell.itemLabel.text = items[indexPath.row]
        cell.priceLabel.text = "$"+price[indexPath.row]
        cell.price = Double(price[indexPath.row])!
        cell.index = indexPath.row
             let url = URL(string: self.imageURLS[indexPath.row])
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) 
            DispatchQueue.main.async {
                cell.itemImage.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
                cell.itemImage.layer.borderWidth = 1
                cell.itemImage.layer.cornerRadius = cell.itemImage.frame.size.width/2
                cell.itemImage.layer.masksToBounds = true
                cell.itemImage.image = UIImage(data: data!)
            }
        }
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
// 
        updateCategory(select: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this will load items from the database in the table view
    func loadItems()
    {
        var myUrl : URL!
        //checks the select category in the table view and selects respective file to
        //retrive data from
        if(lblCategory.text == "Bakery"){myUrl = URL(string: BAKERY_URL)!;}
        else if(lblCategory.text == "Fruits"){myUrl = URL(string: FRUITS_URL)!;}
        else if(lblCategory.text == "Vegetables"){myUrl = URL(string: VEGETABLES_URL)!;}
        else if(lblCategory.text == "Dairy Products"){myUrl = URL(string: DAIRY_URL)!;}
        else if(lblCategory.text == "Meat & Sea Food"){myUrl = URL(string: MEAT_URL)!;}
        else if(lblCategory.text == "Frozen Food"){myUrl = URL(string: FROZEN_URL)!;}
        
      
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let json = JSON(data: data!)
            self.items.removeAll()
            self.price.removeAll()
            self.imageURLS.removeAll()
            for i in 0 ..< json.count  {
                self.items.append(json[i]["name"].stringValue)
                self.price.append(json[i]["price"].stringValue)
                self.imageURLS.append(json[i]["imageurl"].stringValue)
            }
            print(self.imageURLS)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
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
