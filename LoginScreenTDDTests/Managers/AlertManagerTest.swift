//
//  AlertManagerTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest
@testable import LoginScreenTDD

class AlertManagerTest: XCTestCase {
    var alertManager: AlertManager!

    override func setUp() {
        alertManager = AlertManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testReturnsAlert() {
        let alert = alertManager.alert(title: nil, message: nil, okayHandler: nil)
        XCTAssertNotNil(alert)
    }
    
    func testReturnsAlertWithTitle() {
        let alert = alertManager.alert(title: "Some title", message: nil, okayHandler: nil)
        XCTAssertEqual(alert.title, "Some title")
    }
    
    func testReturnsAlertWithMessage() {
        let alert = alertManager.alert(title: nil, message: "Some message", okayHandler: nil)
        XCTAssertEqual(alert.message, "Some message")
    }
    



}
