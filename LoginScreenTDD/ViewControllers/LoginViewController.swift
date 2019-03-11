//
//  LoginViewController.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    let managerContext = ManagerContext.sharedInstance
    
    @IBOutlet weak private var loginTextField: LoginTextField! {
        didSet {
            loginTextField.delegate = self
            loginTextField.placeholder = "Email address"
            loginTextField.accessibilityIdentifier = ConstantsUITests.LoginViewController.usernameTextField
        }
    }
    
    @IBOutlet weak private var passwordTextField: LoginTextField! {
        didSet {
            passwordTextField.delegate = self
            passwordTextField.placeholder = "Password"
            passwordTextField.accessibilityIdentifier = ConstantsUITests.LoginViewController.passwordTextField
        }
    }
    
    @IBOutlet weak private var loginButton: LoginButton! {
        didSet {
            loginButton.setTitle("Log in!", for: .normal)
            loginButton.accessibilityIdentifier = ConstantsUITests.LoginViewController.loginButton
            loginButton.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(button: UIButton) {
        guard let login = loginTextField.text, let pass = passwordTextField.text else { return }
        loginButton.startLoading(style: .white)
        managerContext.loginManager.login(session: URLSession.shared, username: login, password: pass) { [weak self] (data, error) in
            DispatchQueue.main.async {
                self?.loginButton.stopLoading()
            }
            if let error = error {
                self?.showErrorMessage(error: error)
            } else if let data = data {
                self?.showLoginMessage(data: data)
            }
        }
    }
    
    
    
    private func showErrorMessage(error: LoginError) {
        let text: String = {
            switch error {
            case .invalidCredentials:
                return "Please enter a valid username and password"
            case .unknown:
                return "Sorry, something has gone wrong. Please try again."
            }
        }()
        DispatchQueue.main.async {
            let alert = self.managerContext.alertManager.alert(title: nil, message: text) { (action) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alert.view.accessibilityIdentifier = error == .invalidCredentials ? ConstantsUITests.LoginViewController.invalidCredentialsAlert : ConstantsUITests.LoginViewController.unknownErrorAlert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func showLoginMessage(data: Data) {
        DispatchQueue.main.async {
            let text = self.managerContext.loginManager.getTimezone(data: data)
            let message = (text != nil) ? "Welcome to \(text!)" : "Sorry, something has gone wrong. Please try again."
            let alert = self.managerContext.alertManager.alert(title: nil, message: message) { (action) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            alert.view.accessibilityIdentifier = ConstantsUITests.LoginViewController.successAlert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var firstFieldText: String
        
        //Removal of last letter
        if string == "" {
            firstFieldText = textField.text ?? ""
            firstFieldText.removeLast(range.length)
        } else {
            firstFieldText = (textField.text ?? "") + string
        }
        let secondFieldText: String = {
            if textField == self.loginTextField {
                return passwordTextField.text ?? ""
            } else if textField == self.passwordTextField {
                return loginTextField.text ?? ""
            } else {
                return ""
            }
        }()
        
        if (firstFieldText.count == 0 || secondFieldText.count == 0) {
            loginButton.isEnabled = false
        } else {
            loginButton.isEnabled = true
        }
        return true
    }
}
