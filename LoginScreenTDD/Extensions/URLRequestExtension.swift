//
//  URLRequestExtension.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func addHttpBody(dict: [String : String]) {
        
        if dict.count == 0 {
            return
        }
        
        var dataString = ""
        for key in dict.keys {
            if let value = dict[key] {
                dataString.append(contentsOf: "\(key)=\(value)&")
            }
        }
        let data = dataString.data(using: .utf8)
        httpBody = data
    }
    
}
