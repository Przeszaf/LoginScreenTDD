//
//  DictionaryExtension.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    
    func stringOrStringNumber(keyPath: String) -> String? {
        if let string: String = value(keyPath: keyPath) {
            return string
        } else if let int: Int = value(keyPath: keyPath) {
            return String(int)
        } else if let double: Double = value(keyPath: keyPath) {
            return String(double)
        }
        return nil
    }
    
    func value<T: Any>(keyPath: String) -> T? {
        var components = keyPath.split(separator: ".")
        guard let firstComponent = components.first else { return nil }
        let firstComponentString = String(firstComponent)
        if let insideDict = self[firstComponentString] as? [String: Any] {
            components.removeFirst()
            if (components.count == 0) {
                return insideDict as? T
            }
            return insideDict.value(keyPath: components.joined(separator: "."))
        } else {
            guard self[firstComponentString] != nil else { return nil }
            return self[firstComponentString] as? T
        }
    }
}
