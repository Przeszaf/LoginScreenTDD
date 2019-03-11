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
        var components = keyPath.split(separator: ".").map{String($0)}
        guard let firstComponent = components.first else { return nil }
        if let insideDict = self[firstComponent] as? [String: Any] {
            components.removeFirst()
            if (components.count == 0) {
                return insideDict as? T
            }
            return insideDict.value(keyPath: components.joined(separator: "."))
        } else {
            guard self[firstComponent] != nil else { return nil }
            return self[firstComponent] as? T
        }
    }
}
