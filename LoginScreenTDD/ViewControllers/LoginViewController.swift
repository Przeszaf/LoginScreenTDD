//
//  LoginViewController.swift
//  LoginScreenTDD
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var managerContext: ManagerContext!
    let managerContext = ManagerContext.sharedInstance
    
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
        guard let login = loginTextField.text, let pass = passwordTextField.text else { return }
        managerContext.loginManager.login(session: URLSession.shared, username: login, password: pass) { [weak self] (data, error) in
            if let error = error {
                self?.handle(error: error)
            } else if let data = data {
                self?.loginAndSaveToken(data: data)
            }
        }
    }
    

    
    private func handle(error: LoginError) {
        let text: String = {
            switch error {
            case .invalidCredentials:
                return "Please enter a valid username and password"
            case .unknown:
                return "Sorry, something has gone wrong. Please try again."
            }
        }()
        let alert = managerContext.alertManager.alert(title: nil, message: text) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func loginAndSaveToken(data: Data) {
        let text = managerContext.loginManager.getTimezone(data: data)
        let message = (text != nil) ? "Welcome to \(text!)" : "Sorry, something has gone wrong. Please try again."
        let alert = managerContext.alertManager.alert(title: nil, message: message) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        managerContext.loginManager.saveToken(data: data)
    }
}
