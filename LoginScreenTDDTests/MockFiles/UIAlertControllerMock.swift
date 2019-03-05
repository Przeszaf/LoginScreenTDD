//
//  UIAlertControllerMock.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class UIAlertControllerMock: UIAlertController {
    var okayAction: UIAlertActionMock?
    
    convenience init(title: String?, message: String?, preferredStyle: UIAlertController.Style) {
        self.init()
    }
    
    
    override func addAction(_ action: UIAlertAction) {
        if let action = action as? UIAlertActionMock {
            if action.mockTitle?.lowercased() == "ok" {
                okayAction = action
            }
        }
    }
    
}
