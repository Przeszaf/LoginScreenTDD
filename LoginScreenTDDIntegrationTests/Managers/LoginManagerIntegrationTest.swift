//
//  LoginManagerIntegrationTest.swift
//  LoginScreenTDDIntegrationTests
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest

@testable import LoginScreenTDD

class LoginManagerIntegrationTest: XCTestCase {
    var managerContext: ManagerContext!
    
    override func setUp() {
        managerContext = ManagerContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWrongCredentials() {
        let urlExpectation = expectation(description: "URL Response")
        var receivedError: LoginError?
        managerContext.loginManager.login(session: URLSession.shared, username: "user", password: "password") { (data, error) in
            receivedError = error
            urlExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertEqual(receivedError, .invalidCredentials)
    }
    
    func testRightCredentials() {
        let urlExpectation = expectation(description: "URL Response")
        var receivedError: LoginError?
        managerContext.loginManager.login(session: URLSession.shared, username: "c_emp1@grr.la", password: "123456") { (data, error) in
            receivedError = error
            urlExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertNil(receivedError)
    }
    
    
    func testTooShortPassword() {
        let urlExpectation = expectation(description: "URL Response")
        var receivedError: LoginError?
        managerContext.loginManager.login(session: URLSession.shared, username: "c_emp1@grr.la", password: "") { (data, error) in
            receivedError = error
            urlExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertEqual(receivedError, .unknown)
    }
    
    func testRightCredentialsWithToken() {
        let urlExpectation = expectation(description: "URL Response")
        var receivedData: Data?
        managerContext.loginManager.login(session: URLSession.shared, username: "c_emp1@grr.la", password: "123456") { (data, error) in
            receivedData = data
            urlExpectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
        guard let data = receivedData, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {
            XCTFail()
            return
        }
        
        XCTAssertNotNil(json)
    }
    
    func testRightCredentialsWithCompanyTimeZoneName() {
        let urlExpectation = expectation(description: "URL Response")
        var receivedData: Data?
        managerContext.loginManager.login(session: URLSession.shared, username: "c_emp1@grr.la", password: "123456") { (data, error) in
            receivedData = data
            urlExpectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
        guard let data = receivedData, let json = managerContext.jsonManager.parse(data: data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(json.value(keyPath: "companyTimeZoneName"), "Europe/London")
    }
    
    
}

