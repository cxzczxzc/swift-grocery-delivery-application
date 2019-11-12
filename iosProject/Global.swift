//
//  Constants.swift
//  iosProject
//
//  Created by Saad  on 2017-12-26.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/**************************************************************************
 *Authors: Saad Ahmad                                                     *
 *Modified By: Puneet Kaur, Surbhi Handa                                  *
 *Purpose: Storing the global variables of the applications               *
 **************************************************************************/
import Foundation
import Firebase
import FirebaseDatabase

//firebase
let FIREBASE = Database.database().reference()
//user registration endpoint
public let REGISTER_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/register.php"

//save distance and time to mysql
public let DISTANCE_TIME_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/timedistance.php"

//user login endpoint
public let LOGIN_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/login.php"

//grocery list enpoints
public let GROCERY_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/grocery.php"
public let BAKERY_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/bakery.php"
public let MEAT_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/meat.php"
public let FRUITS_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/fruit.php"
public let VEGETABLES_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/vegetable.php"
public let FROZEN_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/frozen.php"
public let DAIRY_URL = "http://handasu.dev.fast.sheridanc.on.ca/ios/category/diary.php"

//main key in firebase
public let PARENT_KEY = "ORDER"

//User, Delivery Address and Store Address details
public var USERNAME : String = ""
public var FLAG : String = ""
public var EMAIL : String = ""
public var ADDRESS = ""
public var ADDRESS_LAT = 0.0
public var ADDRESS_LONG = 0.0
public var STORE = ""
public var STORE_ADDRESS = ""
public var STORE_PHONE = ""
public var STORE_LAT = 0.0
public var STORE_LONG = 0.0
//order details
var orderDetails : [String: OrderItem] = [:]
var orderArray = [OrderItem]()
var orderTotal : Double = 0.0
var TIMESTAMP = 0
//driver location
public var DRIVER_LAT = 0.0
public var DRIVER_LONG = 0.0
public var DRIVER_LOCATION : String = ""
public var DRIVER_ADDRESS : String = ""

