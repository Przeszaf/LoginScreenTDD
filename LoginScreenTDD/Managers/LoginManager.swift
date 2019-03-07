//
//  LoginManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class LoginManager {
    
    func login(session: URLSessionProtocol, username: String, password: String, completionHandler: @escaping ((Data?, LoginError?) -> Void)) {
        let httpManager = HttpManager()
        let request = httpManager.createPostRequest(url: URL(string: "https://brighthr-api-uat.azurewebsites.net/api/Account/PostValidateUser")!,
                                                    parameters: [Constants.LoginManager.usernameParameterKey: username, Constants.LoginManager.passwordParameterKey: password],
                                                    httpHeadersArray: Constants.LoginManager.httpHeadersArray)
        httpManager.get(session: session, request: request) { (data, response, error)  in
            if let response = response as? HTTPURLResponse {
                completionHandler(data, LoginError.check(errorCode: response.statusCode))
            } else if let error = error as? LoginError {
                completionHandler(data, error)
            } else {
                completionHandler(data, nil)
            }
        }
        
        
    }
}
