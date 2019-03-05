//
//  DictionaryExtension.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    func value(keyPath: String) -> Any? {
        let components = keyPath.split(separator: ".")
        if let firstComponentSubstring = components.first, self[String(firstComponentSubstring)] != nil {
            guard let insideDict = self[keyPath] as? [String: Any] else { return self[String(firstComponentSubstring)] }
            if let secondComponentSubstring = components.first, self[String(secondComponentSubstring)] != nil {
                return insideDict[String(secondComponentSubstring)]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
