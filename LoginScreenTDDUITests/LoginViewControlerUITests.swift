//
//  LoginViewControlerUITests.swift
//  LoginScreenTDDUITests
//
//  Created by Przemek Szafulski on 11/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest

@testable import LoginScreenTDD


class LoginViewControlerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginScreenWrongCredentials() {
        let loginButton = app.buttons[ConstantsUITests.LoginViewController.loginButton]
        XCTAssertFalse(loginButton.isEnabled)
        
        let loginTextField = app.textFields[ConstantsUITests.LoginViewController.usernameTextField]
        loginTextField.tap()
        loginTextField.typeText("username")
        XCTAssertFalse(loginButton.isEnabled)
        
        let passwordTextField = app.secureTextFields[ConstantsUITests.LoginViewController.passwordTextField]
        passwordTextField.tap()
        passwordTextField.typeText("password")
        XCTAssertTrue(loginButton.isEnabled)
        
        loginButton.tap()
        sleep(5)
        let invalidCredentialsAlert = app.alerts[ConstantsUITests.LoginViewController.invalidCredentialsAlert]
        XCTAssertTrue(invalidCredentialsAlert.exists)
        invalidCredentialsAlert.buttons.element.tap()
        sleep(3)
        XCTAssertFalse(invalidCredentialsAlert.exists)
    }
    
    func testLoginScreenRightCredentials() {
        let loginButton = app.buttons[ConstantsUITests.LoginViewController.loginButton]
        XCTAssertFalse(loginButton.isEnabled)
        
        let loginTextField = app.textFields[ConstantsUITests.LoginViewController.usernameTextField]
        loginTextField.tap()
        loginTextField.typeText("c_emp1@grr.la")
        XCTAssertFalse(loginButton.isEnabled)
        
        let passwordTextField = app.secureTextFields[ConstantsUITests.LoginViewController.passwordTextField]
        passwordTextField.tap()
        passwordTextField.typeText("123456")
        XCTAssertTrue(loginButton.isEnabled)
        
        loginButton.tap()
        sleep(1)
        let successAlert = app.alerts[ConstantsUITests.LoginViewController.successAlert]
        XCTAssertTrue(successAlert.exists)
        XCTAssertNotNil(successAlert.staticTexts.element.label.range(of: "Welcome"))
        successAlert.buttons.element.tap()
        sleep(3)
        XCTAssertFalse(successAlert.exists)
    }
    
}
