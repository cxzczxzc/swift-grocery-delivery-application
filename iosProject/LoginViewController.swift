//
//  ViewController.swift
//  iosProject
//
//  Created by Saad on 2017-12-08.
//  Copyright © 2017 Xcode User. All rights reserved.
//

/***********************************************************************************
 Author: Saad Ahmad
 Purpose: Login Page 
 *************************************************************************************/
import UIKit
import SpriteKit
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    //instantiate AuthenticationManager
    let auth = AuthencationManager()
    var scene: Animation?
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    
    
    @IBAction func unwindToLoginViewController(segue: UIStoryboardSegue){
        
    }
    
    func textFieldShouldReturn(_ textfield: UITextField )-> Bool {
        return textfield.resignFirstResponder()
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.loginUser()
    }
    
    override func viewDidLoad() {
        loginButtonOutlet.layer.cornerRadius = 5
        registerButtonOutlet.layer.cornerRadius = 5
        super.viewDidLoad()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /***************************************************************************************************
     * Author: Saad Ahmad                                                                              *
     * This method gets user inputs from the fields and validates them                                 *
     * It then calls the LoginUser method from AuthenticationManager class                             *
     * LoginUser returns 'message' which is true if login is successful and false if otherwise         *
     * LoginUser also returns 'data' from which the user details are extracted.                        *
     * A new UserModel is created using the extracted details                                          *
     * The UserModel is used to set the global variables (USERNAME, EMAIL, FLAG)                       *
     * of the application, which are used at various other places                                      *
     ***************************************************************************************************/
    func loginUser()
    {
        let email: String = userNameTextField.text!
        let password : String = passwordTextField.text!
        if userNameTextField.text != "" && passwordTextField.text != ""{
            auth.LoginUser(email: email, password: password, completionHandler: {message, data in
                if message == "true" {
                    let user = UserModel(data: data)
                    USERNAME = user!.name
                    EMAIL = user!.email
                    FLAG = user!.flag
                    if(FLAG == "customer"){
                    DispatchQueue.main.async {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StoresViewController") as! StoresViewController
                    self.present(vc, animated: true, completion: nil)
                    }
                    }
                    else { DispatchQueue.main.async {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DriverViewController") as! DriverViewController
                        self.present(vc, animated: true, completion: nil)
                        }}
                }
                else
                {
                    DispatchQueue.main.async(execute: {
                        self.showAlert(title: "Oops!", message: "Incorrect credentials")
                    })
                }
            })
        }
        else
        {
            self.showAlert(title: "Please check input", message: "All fields are required")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }


}

