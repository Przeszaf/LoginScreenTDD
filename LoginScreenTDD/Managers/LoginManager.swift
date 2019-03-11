//
//  LoginManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class LoginManager: Manager {
    
    var token: String?
    
    func login(session: URLSessionProtocol, username: String, password: String, completionHandler: @escaping ((Data?, LoginError?) -> Void)) {
        let request = managerContext.httpManager.createPostRequest(url: managerContext.urlManager.loginURL(),
                                                                   parameters: [Constants.LoginManager.usernameParameterKey: username, Constants.LoginManager.passwordParameterKey: password],
                                                                   httpHeadersArray: Constants.LoginManager.httpHeadersArray)
        managerContext.httpManager.get(session: session, request: request) { (data, response, error)  in
            if let response = response as? HTTPURLResponse {
                completionHandler(data, LoginError.check(errorCode: response.statusCode))
            } else if let error = error as? LoginError {
                completionHandler(data, error)
            } else {
                completionHandler(data, nil)
            }
        }
    }
    
    func saveToken(data: Data) {
        guard let json = managerContext.jsonManager.parse(data: data) else { return }
        let value: String? = json.value(keyPath: "token.token")
        token = value
    }
    
    func getTimezone(data: Data) -> String? {
        guard let json = managerContext.jsonManager.parse(data: data) else { return nil }
        return json.value(keyPath: "companyTimeZoneName")
    }
    
    
}
