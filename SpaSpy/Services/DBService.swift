//
//  DBService.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import Foundation
import UIKit
import FirebaseDatabase

class DBService: NSObject {

    var ref: DatabaseReference!
    var usersRef: DatabaseReference!
    var reportsRef: DatabaseReference!
    
    static let manager = DBService()
    
    private override init() {
        ref = Database.database().reference()
        reportsRef = ref.child("reports")
        usersRef = ref.child("users")
        super.init()
    }
    
    public func addImageURL(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("imageURL").setValue(url)
        print("Added image url")
    }
}
