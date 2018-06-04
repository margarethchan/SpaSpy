//
//  AppUser.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct AppUser: Codable {
    let userID: String
    var reports: [Report]
    
    init(userID: String, reports: [Report]) {
        self.userID = userID
        self.reports = reports
    }
    
    init?(fromDict userDict: [String: Any]) {
        guard
            let userID = userDict["userID"] as? String,
            let reports = userDict["reports"] as? [Report]
            else {
                return nil
        }
        self.userID = userID
        self.reports = reports
    }
    
    static var currentAppUser: AppUser?
    
    static func configureCurrentAppUser(withUID uid: String, completion: @escaping () -> Void) {
        DBService.manager.getAppUser(fromID: uid, completion: { (appUser) in
            if let appUser = appUser {
                AppUser.currentAppUser = appUser
                print("setup current app user")
                completion()
            } else {
                print("tried and failed to get appUser with uid: \(uid)")
            }
        })
    }
}
