//
//  UserModel.swift
//  iosProject
//
//  Created by Saad  on 2017-12-26.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/**************************************************
 Author: Ankit Shah
 Purpose: Intializing a single object of USER
 **************************************************/
import Foundation
import SwiftyJSON

struct UserModel {
    let name: String
    let email: String
    let flag: String
    init?(data: Data) {
        
        let json = JSON(data: data)
        guard let name = json["name"].string,
            let email = json["email"].string,
            let flag = json["flag"].string
            else { return nil }
        
        self.name = name
        self.email = email
        self.flag = flag
    }
    
}
