//
//  DBService+History.swift
//  SpaSpy
//
//  Created by C4Q on 7/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {

    public func getReports(fromUID uid: String, completion: @escaping (_ reports: [Report]) -> Void) {
        reportsRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            var reports: [Report] = []
            guard let reportSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for reportSnapshot in reportSnapshots {
                guard let reportDict = reportSnapshot.value as? [String: Any] else { return }
            guard
                let reportID = reportDict["reportID"] as? String,
                let posterID = reportDict["posterID"] as? String,
                let timestamp = reportDict["timestamp"] as? String,
                let imageURLs = reportDict["imageURLs"] as? [String]?,
                let name = reportDict["name"] as? String,
                let address = reportDict["address"] as? String,
                let latitude = reportDict["latitude"] as? String,
                let longitude = reportDict["longitude"] as? String,
                let services = reportDict["services"] as? [String],
                let redFlags = reportDict["redFlags"] as? [String],
                let phoneNumbers = reportDict["phoneNumbers"] as? String,
                let webpages = reportDict["webpages"] as? String,
                let notes = reportDict["notes"] as? String
                else {
                    print("Couldn't get report")
                    return
                }
                let report = Report(reportID: reportID, posterID: posterID, timestamp: timestamp, imageURLs: imageURLs ?? [""], name: name, address: address, latitude: latitude, longitude: longitude, services: services, redFlags: redFlags, phoneNumbers: phoneNumbers, webpages: webpages, notes: notes)
            reports.append(report)
            }
            let reportsFromUID = reports.filter{$0.posterID == uid}
            completion(reportsFromUID)
        }
    }
}
