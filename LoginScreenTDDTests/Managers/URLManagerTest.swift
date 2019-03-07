//
//  URLManagerTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest

@testable import LoginScreenTDD

class URLManagerTest: XCTestCase {
    
    var managerContext: ManagerContext!

    override func setUp() {
        managerContext = ManagerContext()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginURL() {
        let url = managerContext.urlManager.loginURL()
        XCTAssertEqual(url.absoluteString, "https://brighthr-api-uat.azurewebsites.net/api/Account/PostValidateUser")
    }


}
