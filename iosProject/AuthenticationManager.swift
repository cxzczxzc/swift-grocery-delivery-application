//
//  AuthenticationManager.swift
//  iosProject
//
//  Created by Saad  on 2017-12-25.
//  Copyright © 2017 Xcode User. All rights reserved.
//

/*************************************
 Author: Saad Ahmad
 Purpose: Handling Login/ Register
 *************************************/

import Foundation
import SwiftyJSON

class AuthencationManager {
    
    /**********************************************************************************************
     *Author: Saad Ahmad                                                                          *
     *This method takes user details as parameters and sends them in a POST request to the server *
     *It has a closure which traps the reponse from the server                                    *
     *The response from server indicates success or failure of user creation                      *
     **********************************************************************************************/
    func RegisterUser(name: String, email: String, password: String, flag: String, completionHandler: @escaping (String) -> Void) -> ()
    {
        let myUrl = URL(string: REGISTER_URL);
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "POST"
        
        let postString = "name="+name+"&email="+email+"&password="+password+"&flag="+flag;
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
    
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let json = JSON(data: data!)
            let message = json["message"].stringValue
            //return message from server indicating success or failure
            completionHandler(message)
            if error != nil
            {
                print("error=\(error)")
            }
        }
        task.resume()
    }
    /***********************************************************************************************
     *Author: Saad Ahmad                                                                           *
     *This method takes user details as parameters and sends them in a POST request to the server  *
     *It has a closure which traps the reponse and data from the server                            *
     *The response from server indicates success or failure of user login                          *
     *In case of success, it is accompanied by user details returned in the form of data, which is  returned in the closure
     ***********************************************************************************************/
    func LoginUser(email: String, password: String, completionHandler : @escaping (String, Data) -> Void) -> ()
    {
        
        let myUrl = URL(string: LOGIN_URL);
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        let postString = "email="+email+"&password="+password;
        request.httpBody = postString.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            let json = JSON(data: data!)
            let message = json["message"].stringValue
            completionHandler(message, data!)
            if error != nil
            {
                print("error=\(error)")
            }
        }
        task.resume()
    }
}
