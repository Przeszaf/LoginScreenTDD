//
//  LoginManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class LoginManager: Manager {
    var session: URLSessionProtocol = URLSession.shared
    var token: String?
    
    func login(session: URLSessionProtocol, username: String, password: String, completionHandler: @escaping ((Data?, LoginError?) -> Void)) {
        let request = managerContext.httpManager.createPostRequest(url: managerContext.urlManager.loginURL(),
                                                                   parameters: [Constants.LoginManager.usernameParameterKey: username, Constants.LoginManager.passwordParameterKey: password],
                                                                   httpHeadersArray: Constants.LoginManager.httpHeadersArray)
        managerContext.httpManager.get(session: session, request: request) { [weak self] (data, response, error)  in
            self?.saveToken(data: data)
            if let response = response as? HTTPURLResponse {
                completionHandler(data, LoginError.check(errorCode: response.statusCode))
            } else if let data = data {
                completionHandler(data, nil)
            } else {
                completionHandler(nil, LoginError.unknown)
            }
        }
    }
    
    private func saveToken(data: Data?) {
        guard let data = data, let json = managerContext.jsonManager.parse(data: data) else { return }
        let value: String? = json.value(keyPath: "token.token")
        token = value
    }
    
    func getTimezone(data: Data) -> String? {
        guard let json = managerContext.jsonManager.parse(data: data) else { return nil }
        return json.value(keyPath: "companyTimeZoneName")
    }
    
    
}
