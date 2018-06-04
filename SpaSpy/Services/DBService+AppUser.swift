//
//  DBService+AppUser.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    
    public func addAppUser(_ appUser: AppUser) {
        let ref = usersRef.child(appUser.userID)
        ref.setValue(["reports" : appUser.reports,
                      "userID" : appUser.userID,
                      ]) { (error, _) in
                        if let error = error {
                            print("\n\tCould not add app user to Database: \(error.localizedDescription)\n")
                        } else {
                            print("\n\tadded new user with uid: \(appUser.userID)\n")
                        }
                        
        }
    }
    
    public func getAppUser(fromID uID: String, completion: @escaping (_ user: AppUser?) -> Void) {
        guard !uID.isEmpty else {
            print("\n\tgot empty user id\n")
            completion(nil)
            return
        }
        
        let userRef = usersRef.child(uID)
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            guard
                let userDict = snapshot.value as? [String: Any],
                var appUser = AppUser(fromDict: userDict)
                
                else {
                    completion(nil)
                    return
            }

            if userDict["reports"] != nil {
                print("\n\tGetting reports history")
                // TODO: Get past reports
                
//                self.getWhims(forUser: appUser, completion: { (whims) in
//                    appUser.hostedWhims = whims
//                    print("got hosted whims")
//                    group.leave()
//                })
            } else {
                print("No user reports")
            }
        }
    }
}
