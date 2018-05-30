//
//  LocationViewController.swift
//  SpaSpy
//
//  Created by C4Q on 5/10/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps

protocol setAddressDelegate: class {
    func setAddress(atAddress: String)
    func setCoordinates(long: String,lat: String)
}

class LocationViewController: UIViewController {

    let locationView = LocationView()
    
    weak var delegate: setAddressDelegate?
    
    // store in the search bar
    var selectedLocation: String = ""
    
    var lat = ""
    var long = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(locationView)
        locationView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        locationView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        locationView.selectLocationButton.addTarget(self, action: #selector(selectLocation), for: .touchUpInside)
        
        locationView.locationManager.delegate = self
        locationView.addLocationMap.delegate = self

        locationView.addLocationMap.settings.myLocationButton = true
        locationView.addLocationMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
    }

    @objc func selectLocation() {
        // replace this with the pin point location from map
        print("Location Selected: \(selectedLocation)")
        delegate?.setAddress(atAddress: selectedLocation)
        delegate?.setCoordinates(long: long, lat: lat)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension LocationViewController: GMSMapViewDelegate{

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        self.long = coordinate.longitude.description
        self.lat = coordinate.latitude.description
        let geo = GMSGeocoder()
//        geo.reverseGeocodeCoordinate(coordinate) { (response, error) in
//            print(response?.firstResult()?.description)
//            let address = (response?.firstResult()?.addressLine1())! + " " + (response?.firstResult()?.addressLine2())!
//            self.selectedLocation = address
//        }

        self.locationView.addLocationMap.clear() // clearing Pin before adding new
        let marker = GMSMarker(position: coordinate)
        marker.icon = GMSMarker.markerImage(with: .red)
        marker.map = self.locationView.addLocationMap

    }

}

extension LocationViewController: CLLocationManagerDelegate{

    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 13.0)
        self.locationView.addLocationMap.camera = camera
    }

    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        // Display the map using the default location.
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }

    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationView.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }

}


