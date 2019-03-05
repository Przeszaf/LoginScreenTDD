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
        var components = keyPath.split(separator: ".")
        guard let firstComponent = components.first else { return nil }
        let firstComponentString = String(firstComponent)
        if let insideDict = self[firstComponentString] as? [String: Any] {
            components.removeFirst()
            if (components.count == 0) {
                return firstComponentString
            }
            return insideDict.value(keyPath: components.joined(separator: "."))
        } else {
            return self[firstComponentString]
        }
    }
}
