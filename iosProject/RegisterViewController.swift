//
//  RegisterViewController.swift
//  iosProject
//
//  Created by Surbhi Handa on 2017-12-08.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import UIKit
import SwiftyJSON
import JHTAlertController

/***********************************************************************************
 Author: Surbhi Handa
 Purpose: Register Page
 *************************************************************************************/
class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    let auth = AuthencationManager()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var checkSwitch: UISwitch!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    
    var flag : String = "customer"
   
    
    
    func textFieldShouldReturn(_ textfield: UITextField )-> Bool {
        return textfield.resignFirstResponder()
        
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        if checkSwitch.isOn {
            self.flag="customer"
            print("Switch is on")
            self.flagLabel.text = "Customer"
        } else {
            self.flag="driver"
               print("Switch is off")
              self.flagLabel.text = "Driver"
            }
    }
    
    @IBAction func buttonRegister( sender: UIButton) {
        self.registerUser()
        print(USERNAME)
        print(EMAIL)
    }
    override func viewDidLoad() {
        registerButtonOutlet.layer.cornerRadius = 5
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*********************************************************************
     * Author: Surbhi Handa
     * This method gets user inputs from the fields and validates them
     * It then calls the RegisterUser from AuthenticationManager class
     * The response from server is displayed in a custom alert view
     *********************************************************************/
    func registerUser()
    {
        let email: String = emailTextField.text!
        let name : String = usernameTextField.text!
        let password : String = passwordTextField.text!
        let flag : String = self.flag
        if emailTextField.text != "" && usernameTextField.text != "" && passwordTextField.text != ""{
            auth.RegisterUser(name: name, email: email, password: password, flag: flag, completionHandler: {message in
                DispatchQueue.main.async(execute: {
                    self.showAlert(title: "Registration Status", message: message)
                })
            })
        }
        else{
         self.showAlert(title: "Please check input", message: "All fields are required")
        }
    }
    
}
