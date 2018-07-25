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
    
    public func saveReport(withImages images: [UIImage]?,
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
            print("Error: could not get current user id.")
            return
        }
        
        let ref = reportsRef.childByAutoId()
        
        let now = Date()
        let dateString = DateFormatter.dateFormatterFull.string(from: now)
        
        let report = Report(reportID: ref.key, posterID: currentUser.uid, timestamp: dateString, imageURLs: [], name: name, address: address, latitude: latitude, longitude: longitude, services: services, redFlags: redFlags, phoneNumbers: phoneNumbers, webpages: webpages, notes: notes)
        
        ref.setValue(["reportID": report.reportID,
                      "posterID": report.posterID,
                      "timestamp": report.timestamp,
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
        StorageService.manager.uploadReportImages(reportImages: images!, toReportID: report.reportID)
    }
    
    private func uploadImages(forIndex index: Int) {
        
    }
    
    public func addImageURLsToReport(urls: [String], reportID: String) {
        addImageURLs(urls: urls, ref: reportsRef, reportID: reportID)
    }

    public func addImageURLs(urls: [String], ref: DatabaseReference, reportID: String) {
        ref.child(reportID).child("imageURLs").setValue(urls)
    }
}
