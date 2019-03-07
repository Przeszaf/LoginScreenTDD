//
//  HttpManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class HttpManager: Manager {
    
    func createPostRequest(url: URL, parameters: [String: String]?, httpHeadersArray: [(value: String, httpHeaderField: String)]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let parameters = parameters {
            request.addHttpBody(dict: parameters)
        }
        if let httpHeadersArray = httpHeadersArray {
            for element in httpHeadersArray {
                request.addValue(element.value, forHTTPHeaderField: element.httpHeaderField)
            }
        }
        return request
    }
    
    func get(session: URLSessionProtocol, request: URLRequest, completionHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let task = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        task.resume()
    }
    
}
