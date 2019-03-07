//
//  LoginManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class LoginManager {
    
    var token: String?
    
    func login(session: URLSessionProtocol, username: String, password: String, completionHandler: @escaping ((Data?, LoginError?) -> Void)) {
        let httpManager = HttpManager()
        let request = httpManager.createPostRequest(url: URL(string: "https://brighthr-api-uat.azurewebsites.net/api/Account/PostValidateUser")!,
                                                    parameters: [Constants.LoginManager.usernameParameterKey: username, Constants.LoginManager.passwordParameterKey: password],
                                                    httpHeadersArray: Constants.LoginManager.httpHeadersArray)
        httpManager.get(session: session, request: request) { [weak self] (data, response, error)  in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self?.getToken(data: data)
            }
            if let response = response as? HTTPURLResponse {
                completionHandler(data, LoginError.check(errorCode: response.statusCode))
            } else if let error = error as? LoginError {
                completionHandler(data, error)
            } else {
                completionHandler(data, nil)
            }
        }
    }
    
    private func getToken(data: Data) {
        let jsonManager = JsonManager()
        guard let json = jsonManager.parse(data: data) else { return }
        token = json.value(keyPath: "token.token")
    }
    
    
}
