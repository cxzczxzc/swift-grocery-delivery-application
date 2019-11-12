//
//  ProgramObject.swift
//  iosProject
//
//  Created by Puneet on 2018-01-01.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import WatchKit
/******************************************************
 Author: Puneet Kaur
 Purpose: Provides a singleton ProgramObject to watchOS
 ******************************************************/
    class ProgramObject: NSObject ,NSCoding{
        var store : String?
        var driver_name : String?
        var eta : String?
        
        func initWithData(store:String,driver_name:String,eta:String)
        {
            self.store = store
            self.driver_name = driver_name
            DRIVER = self.driver_name!
            self.eta = eta
        }
        /**********************************************************************************
         *Author: Puneet Kaur                                                             *
         *Purpose: Create these two methods to handle serialization of data between       *
         *phone and watch.                                                                *
         **********************************************************************************/
        required convenience init?(coder decoder: NSCoder) {
            
            guard let store = decoder.decodeObject(forKey: "store") as? String,
                let driver_name = decoder.decodeObject(forKey: "driver_name") as? String,
                let eta = decoder.decodeObject(forKey: "eta") as? String
                
                else { return nil }
            
            self.init()
            self.initWithData(
                store: store as String,
                driver_name : driver_name as String,
                eta : eta as String
                
            )
        }

        func encode(with coder: NSCoder) {
            coder.encode(self.store, forKey: "store")
            coder.encode(self.driver_name, forKey: "driver_name")
            coder.encode(self.eta, forKey: "eta")
        }
    }
