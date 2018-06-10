//
//  ReportTableViewController+Places.swift
//  SpaSpy
//
//  Created by C4Q on 6/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import GooglePlaces
import GooglePlacePicker

extension ReportTableViewController: GMSPlacePickerViewControllerDelegate {
    
    @objc func addLocation() {
        let config = GMSPlacePickerConfig(viewport: nil)
        // nil viewport centers the map on the device current location instead of a prescribed viewport
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        let businessAddressCellIndexPath = IndexPath(row: 1, section: 0)
        let businessAddressCell = self.tableView.cellForRow(at: businessAddressCellIndexPath) as! AddressTableViewCell
        businessAddressCell.businessNameLabel.text = "Name: " + place.name
        businessAddressCell.businessAddressLabel.text = (place.formattedAddress != nil) ? place.formattedAddress! : "Lat: \(place.coordinate.latitude) + Long: \(place.coordinate.longitude)"
        // set address variables on form
        self.selectedLocation = place
        self.selectedLocationName = place.name
        self.selectedLocationAddress = (place.formattedAddress != nil) ? place.formattedAddress! : "Lat: \(place.coordinate.latitude), Long: \(place.coordinate.longitude)"
        self.selectedLocationLatitude = place.coordinate.latitude.description
        self.selectedLocationLongitude = place.coordinate.longitude.description
        self.tableView.reloadData()
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        print("No place selected")
    }
}
