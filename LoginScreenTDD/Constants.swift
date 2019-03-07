//
//  Constants.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

struct Constants {
    
    struct LoginManager {
        static let httpHeadersArray = [("application/x-www-form-urlencoded", "Content-Type")]
        
        static let passwordParameterKey = "password"
        
        static let usernameParameterKey = "username"
    }
}
