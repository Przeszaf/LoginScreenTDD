//
//  LoginManagerTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest
@testable import LoginScreenTDD

class LoginManagerTest: XCTestCase {
    var loginManager: LoginManager!
    
    override func setUp() {
        loginManager = LoginManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginWrongUsernameOrPassword() {
        let mockURLSession = URLSessionMock()
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "MockUrl")!, statusCode: 403, httpVersion: nil, headerFields: nil)
        var receivedError: LoginError?
        loginManager.login(session: mockURLSession, username: "WrongUsername", password: "WrongPassword", completionHandler: { (data, error) in
            receivedError = error
        })
        XCTAssertEqual(receivedError, .invalidCredentials)
    }
    
    func testLoginCorrectUsernameOrPassword() {
        let mockURLSession = URLSessionMock()
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "MockUrl")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        guard let path = Bundle.main.path(forResource: "response", ofType: "json") else {
            XCTFail()
            return
        }
        mockURLSession.mockData = try? Data(contentsOf: URL(fileURLWithPath: path))
        
        var receivedError: LoginError?
        var receivedData: Data?
        
        loginManager.login(session: mockURLSession, username: "user@mail.com", password: "pass", completionHandler: { (data, error) in
            receivedError = error
            receivedData = data
        })
        guard let data = receivedData,
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {
            XCTFail()
            return
        }
        XCTAssertNil(receivedError)
        let tokenString: String? = json?.value(keyPath: "token.token")
        XCTAssertEqual(tokenString, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOjI1MDUwLCJDb21wYW55SWQiOjIyODQ2LCJFeHBpcnlEYXRlIjoiXC9EYXRlKDE1MDc3Njc2ODE4ODkpXC8ifQ.PNM143ErUvcEfxr0c9bS0vD_wMmMrpYdVkk0YLpHLOk")
    }
    
    func testLoginAnotherError() {
        let mockURLSession = URLSessionMock()
        mockURLSession.mockResponse = HTTPURLResponse(url: URL(string: "AnyUrl")!, statusCode: 123, httpVersion: nil, headerFields: nil)
        var receivedError: LoginError?
        loginManager.login(session: mockURLSession, username: "WrongUsername", password: "WrongPassword", completionHandler: { (data, error) in
            receivedError = error
        })
        XCTAssertEqual(receivedError, .unknown)
    }
}
