//
//  AlertManager.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class AlertManager: Manager {
    
    
    var Action = UIAlertAction.self
    var AlertController = UIAlertController.self
    
    func alert(title: String?, message: String?, okayHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alertController = AlertController.init(title: title, message: message, preferredStyle: .alert)
        if let okayHandler = okayHandler {
            let action = Action.createAction(title: "Ok", style: .default, handler: okayHandler)
            alertController.addAction(action)
        }
        return alertController
    }
}
