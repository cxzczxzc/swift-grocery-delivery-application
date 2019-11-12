//
//  UIViewControllerExtensions.swift
//  iosProject
//
//  Created by Ankit on 2017-12-26.
//  Copyright © 2017 Xcode User. All rights reserved.
//

/******************************************************************************
 Author: Ankit Shah
 Purpose: Extension Added to UIViewController for easily using a custom alert
 ******************************************************************************/

import UIKit
import JHTAlertController
extension UIViewController
{
    /***********************************************************************
     *Author: Ankit Shah                                                   *
     *This method takes the title and message to be displayed as parameters*
     *It displays a custom alert with OK action button                     *
     ***********************************************************************/
    
    func showAlert(title: String, message: String)
    {
        // Setting up an alert with a title and message
        let alertController = JHTAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.titleViewBackgroundColor = UIColor(red:0.20, green:0.13, blue:0.21, alpha:1.0)
        alertController.alertBackgroundColor = .black
        alertController.setButtonBackgroundColorFor(.default, to: .black)
        // Create an action with a completionl handler.
        let okAction = JHTAlertAction(title: "Ok", style: .default) { _ in
        }
        // Add the actions to the alert.
        //alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        // Show the action
        present(alertController, animated: true, completion: nil)
    }
  
}
