//
//  CategoryTableViewController.swift
//  iosProject
//
//  Created by Surbhi Handa on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import UIKit
/***********************************************************************************
 Author: Surbhi Handa
 Purpose: Main View of the TV OS App
 *************************************************************************************/
class CategoryTableViewController: UITableViewController {

    
    let productData = CategoryProducts()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
                return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return productData.categoryNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! ProductCategoryTableViewCell

        // Configure the cell...
        cell.lblCategory.text = productData.categoryNames[indexPath.row]
        cell.imgCategory.image = UIImage(named:productData.category[indexPath.row])
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            let detailViewController = controllers[controllers.count-1]
                as? CategoryViewController
           detailViewController?.updateCategory(select: indexPath.row)
        }

    }
}
