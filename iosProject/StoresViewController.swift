//
//  StoresViewController.swift
//  iosProject
//
//  Created by Puneet on 2017-12-08.
//  Copyright © 2017 Xcode User. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

/***********************************************************************************
 Author: Puneet
 Purpose: StoresViewController
 *************************************************************************************/

class StoresViewController: UIViewController {
    @IBOutlet weak var selectStoreButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var selectedStoreLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
      
    @IBOutlet weak var selectItemsButton: UIButton!
    @IBOutlet weak var welcomeUserLabel: UILabel!

    var resultsViewController: GMSAutocompleteResultsViewController?
    
    @IBAction func selectItemsScreenPresented(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectItemsViewController") as! SelectItemsViewController
        self.present(vc, animated: true, completion: nil)

    }
    
    @IBAction func selectStoresClicked(_ sender: UIButton) {
       self.getSearchView()
    }
    @IBAction func selectAddressClicked(_ sender: UIButton) {
        self.getAddressSelectView()
            }
   var searchController: UISearchController?
   var resultView: UITextView?
    
    override func viewDidLoad() {
        welcomeUserLabel.text = "Welcome, "+USERNAME+"!"
        addressButton.layer.cornerRadius = 0.5 * addressButton.bounds.size.width
        addressButton.clipsToBounds = true
        
        selectStoreButton.layer.cornerRadius = 0.5 * selectStoreButton.bounds.size.width
        selectStoreButton.clipsToBounds = true
        
        selectItemsButton.layer.cornerRadius = 0.5 * selectStoreButton.bounds.size.width
        selectItemsButton.clipsToBounds = true
        
        
        super.viewDidLoad()
       
         }
    override func viewDidAppear(_ animated: Bool) {
            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /***************************************************************************************************
     * Author: Puneet Kaur                                                                             *
     * This method gets called when user wants to select the delivery address                          *
     * It displays GooglePlacePicker view (the place picker with tableview)                            *
     ***************************************************************************************************/
    func getAddressSelectView()
    {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)

    }
    /***************************************************************************************************
     * Author: Puneet Kaur                                                                             *
     * This method gets called when user wants to select the store                                     *
     * It displays GooglePlaces view (the place picker without tableview)                              *
     ***************************************************************************************************/
    func getSearchView()
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
  
    }
    
    @IBAction func unwindToStoresViewController(segue: UIStoryboardSegue){
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
