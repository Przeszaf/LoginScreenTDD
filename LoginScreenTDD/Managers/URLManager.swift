//
//  URLManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class URLManager: Manager {
    func loginURL() -> URL {
        return URL(string: "https://brighthr-api-uat.azurewebsites.net/api/Account/PostValidateUser")!
    }
}
