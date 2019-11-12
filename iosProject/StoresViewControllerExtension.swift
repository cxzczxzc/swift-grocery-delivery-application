//
//  StoresViewControllerExtension.swift
//  iosProject
//
//  Created by Saad  on 2017-12-26.
//  Copyright © 2017 Xcode User. All rights reserved.
//

/*************************************************************************************************
 Author: Puneet
 Purpose: Extension Added to StoresViewController to conform to the protocols required by GooglePlace 
 and Google Place Picker
 *************************************************************************************************/


import Foundation
import GooglePlaces
import GoogleMaps
import GooglePlacePicker
extension StoresViewController: GMSAutocompleteViewControllerDelegate, GMSPlacePickerViewControllerDelegate  {
    
    /***********************************************************************
     *Author: Puneet                                                       *
     *This handles the item selected by user while searching for stores    *
     *The item selected by the user is a place with various properties     *
     *The properties are used to intialize store's global variables        *
     ***********************************************************************/
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       self.selectedStoreLabel.text = place.name
        STORE = place.name
        STORE_ADDRESS = place.formattedAddress!
        STORE_PHONE = place.phoneNumber ?? ""
        STORE_LAT = place.coordinate.latitude
        STORE_LONG = place.coordinate.longitude
       dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    /*****************************************************************************
     *Author: Puneet                                                             *
     *This handles the item selected by user while searching for delivery address*
     *The item selected by the user is a place with various properties           *
     *The properties are used to intialize address's global variables            *
     *****************************************************************************/
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        ADDRESS = place.name
        ADDRESS_LAT = place.coordinate.latitude
        ADDRESS_LONG = place.coordinate.longitude
        print(ADDRESS)
        print(ADDRESS_LAT)
        print(ADDRESS_LONG)
        addressLabel.text=ADDRESS
        // the map tableview dismisses as soon a selection is made
        viewController.dismiss(animated: true, completion: nil)
        
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
}
