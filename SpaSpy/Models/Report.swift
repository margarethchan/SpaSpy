//
//  Report.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

class Report: Codable {
    let reportID: String
    let posterID: String
    let timestamp: String
    let imageURLs: [String]?
    let name: String
    let address: String
    let latitude: String
    let longitude: String
    let services: [String]
    let redFlags: [Flag]
    let phoneNumbers: String
    let webpages: String
    let notes: String
    
    init(reportID: String, posterID: String, timestamp: String, imageURLs: [String], name: String, address: String, latitude: String, longitude: String, services: [String], redFlags: [Flag], phoneNumbers: String, webpages: String, notes: String) {
        self.reportID = reportID
        self.posterID = posterID
        self.timestamp = timestamp
        self.imageURLs = imageURLs
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.services = services
        self.redFlags = redFlags
        self.phoneNumbers = phoneNumbers
        self.webpages = webpages
        self.notes = notes
    }
    
    
}
