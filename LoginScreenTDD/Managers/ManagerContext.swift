//
//  ManagerContext.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import Foundation

class ManagerContext {
    
    static let sharedInstance = ManagerContext()
    
    private(set) lazy var jsonManager = {
        JsonManager(managerContext: self)
    }()
    
    private(set) lazy var urlManager = {
        URLManager(managerContext: self)
    }()
    
    private(set) lazy var httpManager = {
        HttpManager(managerContext: self)
    }()
    
    private(set) lazy var loginManager = {
        LoginManager(managerContext: self)
    }()
    
    private(set) lazy var alertManager = {
        AlertManager(managerContext: self)
    }()
    
    
}
