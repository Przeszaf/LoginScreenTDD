//
//  ManagerContext.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class ManagerContext {
    
    lazy var jsonManager = {
        JsonManager(managerContext: self)
    }()
    
    lazy var urlManager = {
        URLManager(managerContext: self)
    }()
    
    lazy var httpManager = {
        HttpManager(managerContext: self)
    }()
    
    lazy var loginManager = {
        LoginManager(managerContext: self)
    }()
    
    lazy var alertManager = {
        AlertManager(managerContext: self)
    }()
    
    
}
