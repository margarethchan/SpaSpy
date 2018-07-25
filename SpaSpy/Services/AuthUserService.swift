//
//  AuthUserService.swift
//  SpaSpy
//
//  Created by C4Q on 6/3/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    
    static let manager = AuthUserService()
    private var auth: Auth!
    
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
}

