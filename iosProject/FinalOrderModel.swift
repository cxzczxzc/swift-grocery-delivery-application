//
//  FinalOrderModel.swift
//  iosProject
//
//  Created by Puneet on 2018-01-01.
//  Copyright © 2018 Xcode User. All rights reserved.
//

/*********************************************************
 Author: Puneet Kaur
 Purpose: Singleton object FinalOrderModel used for watchOS
 **********************************************************/
import Foundation
import SwiftyJSON

struct FinalOrderModelModel {
    let timestamp: Int
    let eta: String
    let driver: String
    let store : String
    init?(data: Data) {
        
        let json = JSON(data: data)
        guard let timestamp = json["timestamp"].int,
            let eta = json["eta"].string,
            let driver = json["driver"].string,
            let store = json["store"].string
        
            else { return nil }
        
        self.timestamp = timestamp
        self.eta = eta
        self.driver = driver
        self.store = store
    }
    
}

