//
//  LoginViewController.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak private var loginTextField: LoginTextField!
    @IBOutlet weak private var passwordTextField: LoginTextField!
    @IBOutlet weak private var signInButton: LoadingButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.placeholder = "Email address"
        passwordTextField.placeholder = "Password"
        signInButton.setTitle("Log in!", for: .normal)
    }
    
    @IBAction func logIn(button: UIButton) {
        
    }
}
