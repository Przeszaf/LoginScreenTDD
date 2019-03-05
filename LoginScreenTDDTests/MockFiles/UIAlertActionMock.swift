//
//  UIAlertActionMock.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class UIAlertActionMock: UIAlertAction {
    
    var handler: ((UIAlertAction) -> Void)?
    var mockTitle: String?
    
    convenience init(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
        self.init()
        self.handler = handler
        mockTitle = title
    }
    
    
    override class func createAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertActionMock(title: title, style: style, handler: handler)
    }
}
