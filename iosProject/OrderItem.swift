//
//  OrderItem.swift
//  iosProject
//
//  Created by Saad  on 2017-12-28.
//  Copyright © 2017 Xcode User. All rights reserved.

/**************************************************
 Author: Saad Ahmad
 Purpose: Used to create OrderItem objects
 A number of order items together form an order
 **************************************************/

import Foundation


public class OrderItem 
{
    var itemPrice : Double = 0.0
    var finalPrice : Double = 0.0
    var itemName : String = ""
    var itemQuantity : Int = 0
    var itemCategory : String = ""
    var itemURL : String = ""
    
    init?(itemPrice : Double, finalPrice : Double, itemName : String, itemQuantity : Int, itemCategory : String, itemURL:String) {
        self.itemPrice = itemPrice
        self.finalPrice = finalPrice
        self.itemName = itemName
        self.itemQuantity = itemQuantity
        self.itemCategory = itemCategory
        self.itemURL = itemURL
    }
    
    init?(itemName: String, itemQuantity: Int)
    {
     self.itemName = itemName
     self.itemQuantity = itemQuantity
    }
    /*******************************************************************************************
     *Author: Saad Ahmad                                                                       *
     *  This method morphs a single order item into a dictionary                               *
     *  Data in Firebase is stored as key value pairs, which is why dictionaries are suitable  *
     *  PARENT_KEY is the parent key for every order where each order item is added as a child *
     *******************************************************************************************/
    func saveToFirebase(timestamp: String) {
        //let selfUniqueGeneratedId = String(Int(NSDate.timeIntervalSinceReferenceDate * 1000))
        let savePath = FIREBASE.child(PARENT_KEY)
        let dict = ["item" : self.itemName, "quantity": self.itemQuantity, "category" : self.itemCategory] as [String : Any]
        let thisUserRef = savePath.child(timestamp).child("orderlist").childByAutoId()
        thisUserRef.setValue(dict)
    }
    
}
