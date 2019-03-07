//
//  JsonManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class JsonManager: Manager {
    
    func parse(data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : Any]
            return json
        } catch {
            return nil
        }
    }
}
