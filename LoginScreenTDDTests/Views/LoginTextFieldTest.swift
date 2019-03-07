//
//  LoginTextFieldTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest

@testable import LoginScreenTDD

class LoginTextFieldTest: XCTestCase {
    var loginTextField: LoginTextField!
    
    override func setUp() {
        loginTextField = LoginTextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlaceholderWithAttributes() {
        loginTextField.placeholder = "TEST"
        let attributedText = NSAttributedString(string: loginTextField.placeholder!, attributes: [.foregroundColor: Constants.LoginScreen.loginFieldColor])
        XCTAssertEqual(attributedText, loginTextField.attributedPlaceholder)
    }
}
