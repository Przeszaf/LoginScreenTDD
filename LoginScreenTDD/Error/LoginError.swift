//
//  LoginError.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case invalidCredentials
    case unknown
    
    static func check(errorCode: Int) -> LoginError? {
        switch errorCode {
        case 403:
            return .invalidCredentials
        case 200:
            return nil
        default:
            return .unknown
        }
    }
}
