//
//  CategoryProducts.swift
//  iosProject
//
//  Created by Surbhi Handa on 2017-12-27.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/***********************************************************************************
 Author: Surbhi Handa
 Purpose: Used to add categorical pictures to tv os app prior to loading 
          data from PHP endpoint
 *************************************************************************************/
import UIKit

class CategoryProducts: NSObject {

    // define arrays & add images to project
    let category = ["bakery.jpg", "fruits.jpg", "vegetables.jpg", "milk-products.jpg", "meat&seaFood.jpg","frozen.png"]
    
    let categoryNames = ["Bakery", "Fruits", "Vegetables", "Dairy Products", "Meat & Sea Food", "Frozen Food"]
    
    // create variables to hold resulting products data
    var title : String = ""
    var summary : String = ""
    
    }
