//
//  DBService+Report.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    
    public func saveReport(withImage images: [String],
                               name: String,
                               address: String,
                               latitude: String,
                               longitude: String,
                               services: [String],
                               redFlags: [String],
                               phoneNumbers: String,
                               webpages: String,
                               notes: String) {
        guard let currentUser = AuthUserService.manager.getCurrentUser() else {
//        guard let currentUser = AppUser.currentAppUser else {
            print("Error: could not get current user id.")
            return
        }
        
        
        let ref = reportsRef.childByAutoId()
        
        let now = Date()
        let dateString = DateFormatter.dateFormatterFull.string(from: now)
        
        let report = Report(reportID: ref.key, posterID: currentUser.uid, timestamp: dateString, imageURLs: images, name: name, address: address, latitude: latitude, longitude: longitude, services: services, redFlags: redFlags, phoneNumbers: phoneNumbers, webpages: webpages, notes: notes)
        
        ref.setValue(["reportID": report.reportID,
                      "posterID": report.posterID,
                      "timestamp": report.timestamp,
                      "imageURLs": report.imageURLs ?? [],
                      "name": report.name,
                      "address": report.address,
                      "latitude": report.latitude,
                      "longitude": report.longitude,
                      "services": report.services,
                      "redFlags": report.redFlags,
                      "phoneNumbers": report.phoneNumbers,
                      "webpages": report.webpages,
                      "notes": report.notes
        ]) { (error, _) in
            if let error = error {
                print("Error saving report: \(error.localizedDescription)")
            } else {
                print("new report added to database!")
                
            }
        }
        // TODO: Save Images
        
        
    }
}
